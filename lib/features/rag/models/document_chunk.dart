import 'package:flutter/foundation.dart';

@immutable
class DocumentChunk {
  const DocumentChunk({
    required this.id,
    required this.documentId,
    required this.index,
    required this.content,
  });

  final String id;

  /// Parent document ID.
  final String documentId;

  /// Chunk order inside the document.
  final int index;

  /// Text contained in this chunk.
  final String content;

  DocumentChunk copyWith({
    String? id,
    String? documentId,
    int? index,
    String? content,
  }) {
    return DocumentChunk(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      index: index ?? this.index,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentId': documentId,
      'index': index,
      'content': content,
    };
  }

  factory DocumentChunk.fromMap(Map<String, dynamic> map) {
    return DocumentChunk(
      id: map['id'] as String,
      documentId: map['documentId'] as String,
      index: map['index'] as int,
      content: map['content'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentChunk &&
        other.id == id &&
        other.documentId == documentId &&
        other.index == index &&
        other.content == content;
  }

  @override
  int get hashCode => Object.hash(id, documentId, index, content);
}
