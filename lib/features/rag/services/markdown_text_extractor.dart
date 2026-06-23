import 'dart:io';

import '../models/document.dart';
import 'text_extractor.dart';

class MarkdownTextExtractor extends TextExtractor {
  const MarkdownTextExtractor();

  @override
  bool supports(
    Document document,
  ) {
    final path = document.path.toLowerCase();

    return path.endsWith('.md') ||
        path.endsWith('.markdown');
  }

  @override
  Future<String> extract(
    Document document,
  ) async {
    final file = File(document.path);

    if (!await file.exists()) {
      throw Exception(
        'Markdown file not found: ${document.path}',
      );
    }

    final text = await file.readAsString();

    return _normalize(text);
  }

  String _normalize(
    String markdown,
  ) {
    return markdown
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .trim();
  }
}