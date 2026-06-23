import 'package:flutter/foundation.dart';

import '../models/document.dart';
import '../services/document_service.dart';
import '../services/import_document_service.dart';

class DocumentController extends ChangeNotifier {
  DocumentController({
    required DocumentService documentService,
    required ImportDocumentService importService,
  })  : _documentService = documentService,
        _importService = importService;

  final DocumentService _documentService;
  final ImportDocumentService _importService;

  bool _isImporting = false;

  bool get isImporting => _isImporting;

  List<Document> get documents =>
      _documentService.documents;

  int get documentCount =>
      _documentService.count;

  bool get hasDocuments =>
      _documentService.isNotEmpty;

  Future<void> initialize() async {
    await _documentService.initialize();
    notifyListeners();
  }

  Future<void> importDocument(
    Document document,
  ) async {
    if (_isImporting) {
      return;
    }

    _isImporting = true;
    notifyListeners();

    try {
      await _importService.importDocument(
        document,
      );
    } finally {
      _isImporting = false;
      notifyListeners();
    }
  }

  Future<void> deleteDocument(
    String id,
  ) async {
    await _documentService.removeDocument(id);
    notifyListeners();
  }

  Future<void> clearDocuments() async {
    await _documentService.clear();
    notifyListeners();
  }

  List<Document> search(
    String query,
  ) {
    return _documentService.search(query);
  }
}