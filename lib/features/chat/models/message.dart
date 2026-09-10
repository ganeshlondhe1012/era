import 'package:flutter/foundation.dart';

/// Represents a single chat message.
@immutable
class Message {
  /// Unique message ID.
  final String id;

  /// Message content.
  final String text;

  /// True if the message is from the user.
  /// False if it is from Era.
  final bool isUser;

  /// Time when the message was created.
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.text,
    required this.isUser,
    required this.createdAt,
  });

  Message copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isUser': isUser,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      text: map['text'] as String,
      isUser: map['isUser'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, isUser: $isUser, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.text == text &&
        other.isUser == isUser &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(id, text, isUser, createdAt);
  }
}
