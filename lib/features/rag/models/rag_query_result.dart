
import 'document_chunk.dart';

class RagSource {
  const RagSource({
    required this.documentId,
    required this.documentName,
    required this.chunkId,
    required this.chunkIndex,
    required this.score,
  });

  final String documentId;
  final String documentName;
  final String chunkId;
  final int chunkIndex;
  final double score;
}

class RagQueryResult {
  const RagQueryResult({
    required this.answer,
    required this.chunks,
    required this.sources,
  });

  final String answer;
  final List<DocumentChunk> chunks;
  final List<RagSource> sources;
}
