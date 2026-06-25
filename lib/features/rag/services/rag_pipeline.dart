import '../models/document.dart';
import '../models/document_chunk.dart';

import 'chunking_service.dart';
import 'document_service.dart';
import 'embedding_provider.dart';
import 'retrieval_service.dart';
import 'vector_store.dart';

class RagPipeline {
  RagPipeline({
    required this._documentService,
    required this._chunkingService,
    required this._embeddingProvider,
    required this._vectorStore,
    required this._retrievalService,
  });

  final DocumentService _documentService;
  final ChunkingService _chunkingService;
  final EmbeddingProvider _embeddingProvider;
  final VectorStore _vectorStore;
  final RetrievalService _retrievalService;

  /// Index a document into the vector store.
  Future<void> indexDocument({
    required Document document,
    required String text,
  }) async {
    await _documentService.addDocument(document);

    final chunks = _chunkingService.chunkDocument(
      document: document,
      text: text,
    );

    final embeddings =
        await _embeddingProvider.embedChunks(
      chunks,
    );

    _vectorStore.addAll(
      chunks: chunks,
      embeddings: embeddings,
    );
  }

  /// Retrieve relevant chunks for a user query.
  Future<List<DocumentChunk>> retrieve(
    String query, {
    int limit = 5,
  }) {
    return _retrievalService.retrieve(
      query: query,
      limit: limit,
    );
  }

  /// Clears all indexed vectors.
  Future<void> clearIndex() async {
    _vectorStore.clear();
  }

  int get indexedDocuments =>
      _documentService.count;

  int get indexedChunks =>
      _vectorStore.chunkCount;

  bool get hasDocuments =>
      _documentService.isNotEmpty;
}