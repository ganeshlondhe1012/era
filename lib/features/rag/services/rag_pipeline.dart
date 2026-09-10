
import '../models/document.dart';
import '../models/rag_query_result.dart';
import 'document_service.dart';
import 'python_rag_client.dart';

class RagPipeline {
  RagPipeline({
    required this._documentService,
    required this._client,
  });

  final DocumentService _documentService;
  final PythonRagClient _client;

  Future<void>? _initialization;
  int _indexedChunks = 0;

  Future<void> initialize({String embeddingModel = 'nomic-embed-text'}) {
    return _initialization ??= _initialize();
  }

  Future<void> get ready => _initialization ?? Future.value();

  Future<void> _initialize() async {
    await _documentService.initialize();
    try {
      final remote = await _client.getDocuments();
      _indexedChunks = remote.fold<int>(
        0,
        (total, document) => total + document.chunkCount,
      );
    } catch (_) {
      // Era can launch while the local Python service is stopped.
      // RAG operations report the actionable connection error when used.
    }
  }

  Future<Document> indexDocument({required Document document}) async {
    await ready;
    final result = await _client.uploadDocument(document);

    // Use the Python backend's stable content-derived ID locally so later
    // delete/clear operations address the same record on both sides.
    final storedDocument = document.copyWith(id: result.id);
    await _documentService.addDocument(storedDocument);
    _indexedChunks += result.chunkCount;

    return storedDocument;
  }

  Future<RagQueryResult> query({
    required String question,
    required String model,
    int topK = 5,
  }) async {
    await ready;
    return _client.query(question: question, model: model, topK: topK);
  }

  Future<void> removeDocument(String documentId) async {
    await ready;
    await _client.deleteDocument(documentId);
    await _documentService.removeDocument(documentId);
    await _refreshCount();
  }

  Future<void> clearDocuments() async {
    await ready;
    await _client.clearDocuments();
    await _documentService.clear();
    _indexedChunks = 0;
  }

  Future<void> _refreshCount() async {
    try {
      final remote = await _client.getDocuments();
      _indexedChunks = remote.fold<int>(
        0,
        (total, document) => total + document.chunkCount,
      );
    } catch (_) {
      _indexedChunks = 0;
    }
  }

  int get indexedDocuments => _documentService.count;
  int get indexedChunks => _indexedChunks;
  bool get hasDocuments => _documentService.isNotEmpty;
}
