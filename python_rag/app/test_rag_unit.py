
from app.main import CHUNK_OVERLAP, CHUNK_SIZE, chunk_text, cosine_similarity


def test_chunk_overlap_and_coverage():
    text = "abcdefghijklmnopqrstuvwxyz"
    chunks = chunk_text(text, size=10, overlap=2)
    assert chunks
    assert chunks[0] == "abcdefghij"
    assert chunks[1].startswith("ijklmnop")


def test_cosine_similarity_identity():
    assert abs(cosine_similarity([1, 0], [1, 0]) - 1.0) < 1e-6


def test_cosine_similarity_orthogonal():
    assert abs(cosine_similarity([1, 0], [0, 1])) < 1e-6


def test_cosine_similarity_mismatch():
    assert cosine_similarity([1, 0], [1]) == -1.0
