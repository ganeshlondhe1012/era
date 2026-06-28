import 'package:flutter/foundation.dart';

@immutable
class Document {
  const Document({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String path;
  final int size;
  final DateTime createdAt;

  Document copyWith({
    String? id,
    String? name,
    String? path,
    int? size,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
