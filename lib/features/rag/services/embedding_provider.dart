import '../models/document_chunk.dart';
import '../models/document_embedding.dart';

/// Interface for generating embeddings.
///
/// Different implementations can use:
/// - Ollama embeddings
/// - llama.cpp embeddings
/// - ONNX models
/// - OpenAI (future, optional)
abstract class EmbeddingProvider {
  /// Generates an embedding for a single chunk.
  Future<DocumentEmbedding> embedChunk(DocumentChunk chunk);

  /// Generates embeddings for multiple chunks.
  Future<List<DocumentEmbedding>> embedChunks(
    List<DocumentChunk> chunks,
  ) async {
    final embeddings = <DocumentEmbedding>[];

    for (final chunk in chunks) {
      embeddings.add(await embedChunk(chunk));
    }

    return embeddings;
  }
}
