import 'dart:io';

class DocumentTextExtractor {
  const DocumentTextExtractor();

  Future<String> extract({
    required String path,
  }) async {
    final extension =
        path.split('.').last.toLowerCase();

    switch (extension) {
      case 'txt':
      case 'md':
        return _readTextFile(path);

      case 'pdf':
        throw UnimplementedError(
          'PDF extraction not implemented yet.',
        );

      case 'docx':
        throw UnimplementedError(
          'DOCX extraction not implemented yet.',
        );

      default:
        throw UnsupportedError(
          'Unsupported document type: $extension',
        );
    }
  }

  Future<String> _readTextFile(
    String path,
  ) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception(
        'Document not found.',
      );
    }

    return file.readAsString();
  }
}