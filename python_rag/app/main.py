
from __future__ import annotations

import hashlib
import os
import sqlite3
from pathlib import Path
from typing import Any
from contextlib import asynccontextmanager

import httpx
import numpy as np
from fastapi import FastAPI, File, HTTPException, UploadFile
from pydantic import BaseModel, Field

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = Path(os.getenv("DATA_DIR", str(BASE_DIR / "data")))
DATA_DIR.mkdir(parents=True, exist_ok=True)
DB_PATH = DATA_DIR / "era_rag.db"

OLLAMA_BASE_URL = os.getenv("OLLAMA_BASE_URL", "http://127.0.0.1:11434").rstrip("/")
EMBEDDING_MODEL = os.getenv("EMBEDDING_MODEL", "nomic-embed-text")
DEFAULT_TOP_K = int(os.getenv("DEFAULT_TOP_K", "5"))
MAX_UPLOAD_BYTES = int(os.getenv("MAX_UPLOAD_BYTES", str(10 * 1024 * 1024)))
CHUNK_SIZE = 1000
CHUNK_OVERLAP = 200


class QueryRequest(BaseModel):
    question: str = Field(min_length=1, max_length=8000)
    model: str = Field(min_length=1, max_length=200)
    top_k: int = Field(default=DEFAULT_TOP_K, ge=1, le=20)


class Source(BaseModel):
    document_id: str
    document_name: str
    chunk_id: str
    chunk_index: int
    score: float


class QueryResponse(BaseModel):
    answer: str
    sources: list[Source]


class DocumentResponse(BaseModel):
    id: str
    name: str
    size: int
    chunk_count: int
    embedding_model: str


@asynccontextmanager
async def lifespan(_: FastAPI):
    init_db()
    yield


app = FastAPI(
    title="Era Python RAG Service",
    version="1.0.0",
    lifespan=lifespan,
)


def db() -> sqlite3.Connection:
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")
    return conn


def init_db() -> None:
    with db() as conn:
        conn.executescript(
            """
            CREATE TABLE IF NOT EXISTS documents (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                size INTEGER NOT NULL,
                sha256 TEXT NOT NULL,
                embedding_model TEXT NOT NULL,
                created_at TEXT NOT NULL
            );

            CREATE TABLE IF NOT EXISTS chunks (
                id TEXT PRIMARY KEY,
                document_id TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
                chunk_index INTEGER NOT NULL,
                content TEXT NOT NULL
            );

            CREATE TABLE IF NOT EXISTS embeddings (
                chunk_id TEXT PRIMARY KEY REFERENCES chunks(id) ON DELETE CASCADE,
                vector_json TEXT NOT NULL
            );

            CREATE INDEX IF NOT EXISTS idx_chunks_document_id
            ON chunks(document_id);
            """
        )


def chunk_text(text: str, size: int = CHUNK_SIZE, overlap: int = CHUNK_OVERLAP) -> list[str]:
    text = text.strip()
    if not text:
        return []
    if size <= 0 or overlap < 0 or overlap >= size:
        raise ValueError("Invalid chunk configuration")

    chunks: list[str] = []
    start = 0
    while start < len(text):
        end = min(start + size, len(text))
        content = text[start:end].strip()
        if content:
            chunks.append(content)
        if end == len(text):
            break
        start = end - overlap
    return chunks


def cosine_similarity(a: list[float], b: list[float]) -> float:
    if len(a) != len(b) or not a:
        return -1.0
    av = np.asarray(a, dtype=np.float32)
    bv = np.asarray(b, dtype=np.float32)
    denom = float(np.linalg.norm(av) * np.linalg.norm(bv))
    if denom == 0:
        return -1.0
    score = float(np.dot(av, bv) / denom)
    return score if np.isfinite(score) else -1.0


async def ollama_embed(texts: list[str]) -> list[list[float]]:
    if not texts:
        return []
    async with httpx.AsyncClient(timeout=120.0) as client:
        response = await client.post(
            f"{OLLAMA_BASE_URL}/api/embed",
            json={"model": EMBEDDING_MODEL, "input": texts},
        )
    if response.status_code != 200:
        raise HTTPException(
            status_code=502,
            detail=f"Ollama embedding failed ({response.status_code}): {response.text}",
        )
    payload = response.json()
    vectors = payload.get("embeddings")
    if not isinstance(vectors, list) or len(vectors) != len(texts):
        raise HTTPException(status_code=502, detail="Ollama returned an invalid embedding response.")
    return [[float(x) for x in vector] for vector in vectors]


async def ollama_generate(model: str, prompt: str) -> str:
    async with httpx.AsyncClient(timeout=300.0) as client:
        response = await client.post(
            f"{OLLAMA_BASE_URL}/api/chat",
            json={
                "model": model,
                "stream": False,
                "messages": [{"role": "user", "content": prompt}],
            },
        )
    if response.status_code != 200:
        raise HTTPException(
            status_code=502,
            detail=f"Ollama generation failed ({response.status_code}): {response.text}",
        )
    payload = response.json()
    content = payload.get("message", {}).get("content")
    if not isinstance(content, str) or not content.strip():
        raise HTTPException(status_code=502, detail="Ollama returned an empty answer.")
    return content.strip()


@app.get("/health")
async def health() -> dict[str, Any]:
    ollama_ok = False
    detail = "Ollama unavailable"
    try:
        async with httpx.AsyncClient(timeout=3.0) as client:
            response = await client.get(f"{OLLAMA_BASE_URL}/api/tags")
            ollama_ok = response.status_code == 200
            detail = "ok" if ollama_ok else response.text
    except Exception as exc:
        detail = str(exc)
    return {
        "status": "ok",
        "ollama": ollama_ok,
        "embedding_model": EMBEDDING_MODEL,
        "detail": detail,
    }


@app.get("/documents", response_model=list[DocumentResponse])
def documents() -> list[DocumentResponse]:
    with db() as conn:
        rows = conn.execute(
            """
            SELECT d.*, COUNT(c.id) AS chunk_count
            FROM documents d
            LEFT JOIN chunks c ON c.document_id = d.id
            GROUP BY d.id
            ORDER BY d.created_at DESC
            """
        ).fetchall()
    return [
        DocumentResponse(
            id=row["id"],
            name=row["name"],
            size=row["size"],
            chunk_count=row["chunk_count"],
            embedding_model=row["embedding_model"],
        )
        for row in rows
    ]


@app.post("/documents/upload", response_model=DocumentResponse)
async def upload_document(file: UploadFile = File(...)) -> DocumentResponse:
    name = Path(file.filename or "document").name
    suffix = Path(name).suffix.lower()
    if suffix not in {".txt", ".md", ".markdown"}:
        raise HTTPException(status_code=415, detail="Only TXT and Markdown documents are supported.")

    data = await file.read()
    if len(data) > MAX_UPLOAD_BYTES:
        raise HTTPException(status_code=413, detail="Document exceeds the configured upload size limit.")

    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError as exc:
        raise HTTPException(status_code=400, detail="Document must be UTF-8 text.") from exc

    chunks = chunk_text(text)
    if not chunks:
        raise HTTPException(status_code=400, detail="Document contains no readable text.")

    document_id = hashlib.sha256(data).hexdigest()[:24]
    sha256 = hashlib.sha256(data).hexdigest()
    vectors = await ollama_embed(chunks)

    if len(vectors) != len(chunks):
        raise HTTPException(status_code=502, detail="Embedding count does not match chunk count.")

    try:
        with db() as conn:
            conn.execute("DELETE FROM documents WHERE id = ?", (document_id,))
            conn.execute(
                """
                INSERT INTO documents(id, name, size, sha256, embedding_model, created_at)
                VALUES (?, ?, ?, ?, ?, datetime('now'))
                """,
                (document_id, name, len(data), sha256, EMBEDDING_MODEL),
            )
            for index, (content, vector) in enumerate(zip(chunks, vectors)):
                chunk_id = f"{document_id}_{index}"
                conn.execute(
                    "INSERT INTO chunks(id, document_id, chunk_index, content) VALUES (?, ?, ?, ?)",
                    (chunk_id, document_id, index, content),
                )
                conn.execute(
                    "INSERT INTO embeddings(chunk_id, vector_json) VALUES (?, ?)",
                    (chunk_id, json_dumps(vector)),
                )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"Failed to persist document: {exc}") from exc

    return DocumentResponse(
        id=document_id,
        name=name,
        size=len(data),
        chunk_count=len(chunks),
        embedding_model=EMBEDDING_MODEL,
    )


@app.delete("/documents/{document_id}")
def delete_document(document_id: str) -> dict[str, Any]:
    with db() as conn:
        cur = conn.execute("DELETE FROM documents WHERE id = ?", (document_id,))
    if cur.rowcount == 0:
        raise HTTPException(status_code=404, detail="Document not found.")
    return {"deleted": True, "id": document_id}


@app.delete("/documents")
def clear_documents() -> dict[str, Any]:
    with db() as conn:
        conn.execute("DELETE FROM documents")
    return {"cleared": True}


@app.post("/rag/query", response_model=QueryResponse)
async def rag_query(request: QueryRequest) -> QueryResponse:
    question = request.question.strip()
    query_vector = (await ollama_embed([question]))[0]

    with db() as conn:
        rows = conn.execute(
            """
            SELECT
                c.id AS chunk_id,
                c.document_id,
                c.chunk_index,
                c.content,
                d.name AS document_name,
                e.vector_json
            FROM chunks c
            JOIN embeddings e ON e.chunk_id = c.id
            JOIN documents d ON d.id = c.document_id
            WHERE d.embedding_model = ?
            """,
            (EMBEDDING_MODEL,),
        ).fetchall()

    if not rows:
        raise HTTPException(status_code=404, detail="No indexed documents found.")

    scored: list[tuple[float, sqlite3.Row]] = []
    for row in rows:
        vector = json_loads(row["vector_json"])
        score = cosine_similarity(query_vector, vector)
        if score >= -1.0:
            scored.append((score, row))

    scored.sort(key=lambda item: item[0], reverse=True)
    selected = scored[: request.top_k]

    if not selected:
        raise HTTPException(status_code=404, detail="No retrievable document context found.")

    context_parts = []
    sources: list[Source] = []
    for score, row in selected:
        context_parts.append(
            f"[Source: {row['document_name']} | Chunk {row['chunk_index'] + 1}]\n{row['content']}"
        )
        sources.append(
            Source(
                document_id=row["document_id"],
                document_name=row["document_name"],
                chunk_id=row["chunk_id"],
                chunk_index=row["chunk_index"],
                score=round(score, 6),
            )
        )

    prompt = f"""You are Era's document assistant.
Answer the user's question using ONLY the supplied document context.
If the context does not contain the answer, explicitly say that you cannot find the answer in the imported documents.
Do not invent facts that are not supported by the context.

DOCUMENT CONTEXT
----------------
{chr(10).join(context_parts)}

USER QUESTION
-------------
{question}
"""

    answer = await ollama_generate(request.model.strip(), prompt)
    return QueryResponse(answer=answer, sources=sources)


# Small helpers kept local so the service has one serialization format.
def json_dumps(value: Any) -> str:
    import json
    return json.dumps(value, separators=(",", ":"))


def json_loads(value: str) -> Any:
    import json
    return json.loads(value)
