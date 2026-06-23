import 'package:flutter/foundation.dart';

@immutable
class DocumentEmbedding {
  const DocumentEmbedding({
    required this.chunkId,
    required this.documentId,
    required this.vector,
  });

  /// ID of the chunk this embedding belongs to.
  final String chunkId;

  /// Parent document ID.
  final String documentId;

  /// Embedding vector.
  final List<double> vector;

  DocumentEmbedding copyWith({
    String? chunkId,
    String? documentId,
    List<double>? vector,
  }) {
    return DocumentEmbedding(
      chunkId: chunkId ?? this.chunkId,
      documentId: documentId ?? this.documentId,
      vector: vector ?? this.vector,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chunkId': chunkId,
      'documentId': documentId,
      'vector': vector,
    };
  }

  factory DocumentEmbedding.fromMap(
    Map<String, dynamic> map,
  ) {
    return DocumentEmbedding(
      chunkId: map['chunkId'] as String,
      documentId: map['documentId'] as String,
      vector: List<double>.from(
        map['vector'] as List,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentEmbedding &&
        other.chunkId == chunkId &&
        other.documentId == documentId &&
        listEquals(other.vector, vector);
  }

  @override
  int get hashCode =>
      Object.hash(
        chunkId,
        documentId,
        Object.hashAll(vector),
      );
}