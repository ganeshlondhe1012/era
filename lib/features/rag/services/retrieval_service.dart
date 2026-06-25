import '../models/document_chunk.dart';
import 'embedding_provider.dart';
import 'vector_store.dart';

class RetrievalService {
  RetrievalService({
    required this._embeddingProvider,
    required this._vectorStore,
  });

  final EmbeddingProvider _embeddingProvider;
  final VectorStore _vectorStore;

  /// Returns the most relevant chunks for a query.
  Future<List<DocumentChunk>> retrieve({
    required String query,
    int limit = 5,
  }) async {
    final queryChunk = DocumentChunk(
      id: '__query__',
      documentId: '__query__',
      index: 0,
      content: query,
    );

    final embedding =
        await _embeddingProvider.embedChunk(
      queryChunk,
    );

    return _vectorStore.search(
      queryVector: embedding.vector,
      limit: limit,
    );
  }
}