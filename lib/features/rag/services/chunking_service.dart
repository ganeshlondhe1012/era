import '../models/document.dart';
import '../models/document_chunk.dart';

class ChunkingService {
  const ChunkingService();

  /// Splits text into fixed-size chunks.
  ///
  /// Later this will become semantic chunking.
  List<DocumentChunk> chunkDocument({
    required Document document,
    required String text,
    int chunkSize = 1000,
    int overlap = 200,
  }) {
    if (text.trim().isEmpty) {
      return [];
    }

    assert(chunkSize > overlap, 'chunkSize must be greater than overlap.');

    final chunks = <DocumentChunk>[];

    int start = 0;
    int index = 0;

    while (start < text.length) {
      final end = (start + chunkSize).clamp(0, text.length);

      final content = text.substring(start, end).trim();

      if (content.isNotEmpty) {
        chunks.add(
          DocumentChunk(
            id: '${document.id}_$index',
            documentId: document.id,
            index: index,
            content: content,
          ),
        );
      }

      if (end == text.length) {
        break;
      }

      start = end - overlap;
      index++;
    }

    return chunks;
  }
}
