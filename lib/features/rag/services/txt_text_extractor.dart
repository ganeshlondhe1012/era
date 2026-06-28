import 'dart:io';

import '../models/document.dart';
import 'text_extractor.dart';

class TxtTextExtractor extends TextExtractor {
  const TxtTextExtractor();

  @override
  bool supports(Document document) {
    return document.path.toLowerCase().endsWith('.txt');
  }

  @override
  Future<String> extract(Document document) async {
    final file = File(document.path);

    if (!await file.exists()) {
      throw Exception('Text file not found: ${document.path}');
    }

    return file.readAsString();
  }
}
