import 'dart:io';

import '../models/document.dart';

import 'file_picker_service.dart';
import 'import_document_service.dart';

class DocumentImportWorkflow {
  DocumentImportWorkflow({
    required this._filePickerService,
    required this._importService,
  });

  final FilePickerService _filePickerService;
  final ImportDocumentService _importService;

  /// Opens the file picker and imports a single document.
  Future<Document?> importSingle() async {
    final path = await _filePickerService.pickDocument();

    if (path == null) {
      return null;
    }

    final document = await _createDocument(path);

    return _importService.importDocument(document);
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

      imported.add(await _importService.importDocument(document));
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

    return document;
  }
}
