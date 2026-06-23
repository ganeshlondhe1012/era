import '../models/document.dart';

import 'rag_pipeline.dart';
import 'text_extractor.dart';

class ImportDocumentService {
  ImportDocumentService({
    required RagPipeline pipeline,
    required List<TextExtractor> extractors,
  })  : _pipeline = pipeline,
        _extractors = extractors;

  final RagPipeline _pipeline;
  final List<TextExtractor> _extractors;

  /// Imports and indexes a document.
  Future<void> importDocument(
    Document document,
  ) async {
    final extractor = _findExtractor(document);

    if (extractor == null) {
      throw UnsupportedError(
        'Unsupported document type: ${document.path}',
      );
    }

    final text = await extractor.extract(
      document,
    );

    if (text.trim().isEmpty) {
      throw Exception(
        'Document contains no readable text.',
      );
    }

    await _pipeline.indexDocument(
      document: document,
      text: text,
    );
  }

  bool supports(
    Document document,
  ) {
    return _findExtractor(document) != null;
  }

  List<String> supportedExtensions() {
    return _extractors
        .map((extractor) {
          if (extractor.runtimeType
              .toString()
              .contains('Txt')) {
            return '.txt';
          }

          if (extractor.runtimeType
              .toString()
              .contains('Markdown')) {
            return '.md';
          }

          return 'Unknown';
        })
        .toList();
  }

  TextExtractor? _findExtractor(
    Document document,
  ) {
    for (final extractor in _extractors) {
      if (extractor.supports(document)) {
        return extractor;
      }
    }

    return null;
  }
}