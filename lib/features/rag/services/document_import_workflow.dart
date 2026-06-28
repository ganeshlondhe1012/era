import 'dart:io';

import '../models/document.dart';

import 'document_service.dart';
import 'file_picker_service.dart';
import 'import_document_service.dart';

class DocumentImportWorkflow {
  DocumentImportWorkflow({
    required this._filePickerService,
    required this._importService,
    required this._documentService,
  });

  final FilePickerService _filePickerService;
  final ImportDocumentService _importService;
  final DocumentService _documentService;

  /// Opens the file picker and imports a single document.
  Future<Document?> importSingle() async {
    final path = await _filePickerService.pickDocument();

    if (path == null) {
      return null;
    }

    final document = await _createDocument(path);

    await _importService.importDocument(document);

    return document;
  }

  /// Opens the file picker and imports multiple documents.
  Future<List<Document>> importMultiple() async {
    final paths = await _filePickerService.pickDocuments();

    if (paths.isEmpty) {
      return [];
    }

    final imported = <Document>[];

    for (final path in paths) {
      final document = await _createDocument(path);

      await _importService.importDocument(document);

      imported.add(document);
    }

    return imported;
  }

  Future<Document> _createDocument(String path) async {
    final file = File(path);

    final stat = await file.stat();

    final document = Document(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: file.uri.pathSegments.last,
      path: path,
      size: stat.size,
      createdAt: DateTime.now(),
    );

    await _documentService.addDocument(document);

    return document;
  }
}
