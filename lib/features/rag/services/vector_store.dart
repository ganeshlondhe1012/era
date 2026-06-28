import '../models/document_chunk.dart';
import '../models/document_embedding.dart';
import 'dart:math' as math;

class VectorStore {
  final List<DocumentEmbedding> _embeddings = [];
  final Map<String, DocumentChunk> _chunks = {};

  void clear() {
    _embeddings.clear();
    _chunks.clear();
  }

  void add(DocumentChunk chunk, DocumentEmbedding embedding) {
    _chunks[chunk.id] = chunk;

    _embeddings.removeWhere((e) => e.chunkId == embedding.chunkId);

    _embeddings.add(embedding);
  }

  void addAll({
    required List<DocumentChunk> chunks,
    required List<DocumentEmbedding> embeddings,
  }) {
    assert(
      chunks.length == embeddings.length,
      'Chunks and embeddings length must match.',
    );

    for (var i = 0; i < chunks.length; i++) {
      add(chunks[i], embeddings[i]);
    }
  }

  List<DocumentChunk> search({
    required List<double> queryVector,
    int limit = 5,
  }) {
    final scores = <({double score, DocumentChunk chunk})>[];

    for (final embedding in _embeddings) {
      final chunk = _chunks[embedding.chunkId];

      if (chunk == null) {
        continue;
      }

      scores.add((
        score: _cosineSimilarity(queryVector, embedding.vector),
        chunk: chunk,
      ));
    }

    scores.sort((a, b) => b.score.compareTo(a.score));

    return scores.take(limit).map((e) => e.chunk).toList();
  }

  double _cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) {
      return -1;
    }

    double dot = 0;
    double normA = 0;
    double normB = 0;

    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    if (normA == 0 || normB == 0) {
      return -1;
    }

    return dot / (math.sqrt(normA) * math.sqrt(normB));
  }

  int get embeddingCount => _embeddings.length;

  int get chunkCount => _chunks.length;

  bool get isEmpty => _embeddings.isEmpty;
}

extension on double {
  double sqrt() {
    return Math.sqrt(this);
  }
}

class Math {
  static double sqrt(double value) {
    return value <= 0
        ? 0
        : value == 1
        ? 1
        : _sqrtNewton(value);
  }

  static double _sqrtNewton(double value) {
    double x = value;

    while (true) {
      final next = 0.5 * (x + value / x);

      if ((x - next).abs() < 0.000001) {
        return next;
      }

      x = next;
    }
  }
}
