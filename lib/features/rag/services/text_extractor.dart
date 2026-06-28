import '../models/document.dart';

/// Base interface for extracting text from documents.
///
/// Future implementations:
/// - TxtTextExtractor
/// - MarkdownTextExtractor
/// - PdfTextExtractor
/// - DocxTextExtractor
abstract class TextExtractor {
  const TextExtractor();

  /// Whether this extractor supports the document.
  bool supports(Document document);

  /// Extracts plain text from the document.
  Future<String> extract(Document document);
}
