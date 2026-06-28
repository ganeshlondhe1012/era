import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class DocumentTextExtractor {
  const DocumentTextExtractor();

  Future<String> extract({required String path}) async {
    final extension = path.split('.').last.toLowerCase();

    switch (extension) {
      case 'txt':
      case 'md':
        return _readTextFile(path);

      case 'pdf':
        return _readPdf(path);

      case 'docx':
        throw UnimplementedError('DOCX extraction not implemented yet.');

      default:
        throw UnsupportedError('Unsupported document type: $extension');
    }
  }

  Future<String> _readPdf(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception('PDF not found.');
    }

    final bytes = await file.readAsBytes();

    final document = PdfDocument(inputBytes: bytes);

    try {
      final extractor = PdfTextExtractor(document);

      final text = extractor.extractText();

      if (text.trim().isEmpty) {
        throw Exception('No readable text found in PDF.');
      }

      return text;
    } finally {
      document.dispose();
    }
  }

  Future<String> _readTextFile(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception('Document not found.');
    }

    return file.readAsString();
  }
}
