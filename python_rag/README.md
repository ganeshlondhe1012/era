# Era Python RAG Service

Local FastAPI service used by the Era Flutter desktop app.

## Responsibilities

- TXT/Markdown document ingestion
- UTF-8 text extraction
- Fixed-size overlapping chunking
- Ollama embeddings (`nomic-embed-text`)
- SQLite vector persistence
- Cosine-similarity retrieval
- RAG prompt construction
- Ollama LLM generation

## Requirements

- Python 3.11+
- Ollama running locally
- `nomic-embed-text` installed
- A chat-capable Ollama model installed

```bash
ollama pull nomic-embed-text
ollama list
```

## Start

Windows:

```powershell
.\start_rag_service.ps1
```

Command line:

```bash
python -m venv .venv
# activate the environment
pip install -r requirements.txt
python -m uvicorn app.main:app --host 127.0.0.1 --port 8787
```

The service listens on `http://127.0.0.1:8787`.

## Endpoints

- `GET /health`
- `GET /documents`
- `POST /documents/upload`
- `DELETE /documents/{document_id}`
- `DELETE /documents`
- `POST /rag/query`

## Storage

The service stores its SQLite index under `python_rag/data/era_rag.db`.

The database contains document metadata, chunks, and embeddings. This is intentionally a small local MVP; a dedicated vector database can replace it later.

## RAG flow

```text
Document
  -> extract text
  -> chunk with overlap
  -> embed each chunk with Ollama
  -> persist chunks + vectors in SQLite

Question
  -> embed question with same embedding model
  -> cosine similarity against stored vectors
  -> select top-k chunks
  -> inject retrieved chunks into prompt
  -> Ollama chat model generates answer
```

## Supported formats

`.txt`, `.md`, `.markdown`

PDF/DOCX/OCR are intentionally outside the MVP.
