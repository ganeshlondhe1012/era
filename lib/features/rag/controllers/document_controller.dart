import 'package:flutter/foundation.dart';

import '../models/document.dart';
import '../services/document_import_workflow.dart';
import '../services/document_service.dart';
import '../services/rag_pipeline.dart';

class DocumentController extends ChangeNotifier {
  DocumentController({
    required this._documentService,
    required this._workflow,
    required this._ragPipeline,
  });

  final DocumentService _documentService;
  final DocumentImportWorkflow _workflow;
  final RagPipeline _ragPipeline;

  bool _isImporting = false;
  String? _error;

  bool get isImporting => _isImporting;
  String? get error => _error;
  List<Document> get documents => _documentService.documents;
  int get documentCount => _documentService.count;
  int get indexedChunks => _ragPipeline.indexedChunks;
  bool get hasDocuments => _documentService.isNotEmpty;

  Future<void> initialize() async {
    await _ragPipeline.initialize(embeddingModel: 'nomic-embed-text');
    notifyListeners();
  }

  Future<void> importPickedDocument() async {
    if (_isImporting) return;

    _isImporting = true;
    _error = null;
    notifyListeners();

    try {
      await _workflow.importSingle();
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isImporting = false;
      notifyListeners();
    }
  }

  Future<void> deleteDocument(String id) async {
    await _ragPipeline.removeDocument(id);
    notifyListeners();
  }

  Future<void> clearDocuments() async {
    await _ragPipeline.clearDocuments();
    notifyListeners();
  }

  List<Document> search(String query) => _documentService.search(query);
}
