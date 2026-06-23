import 'package:flutter/foundation.dart';

import 'message.dart';

@immutable
class Chat {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.messages,
  });

  Chat copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }

  bool get isEmpty => messages.isEmpty;

  int get messageCount => messages.length;

  /// Serialize chat for persistence.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'messages': messages
          .map((message) => message.toMap())
          .toList(),
    };
  }

  /// Deserialize chat from persistence.
  factory Chat.fromMap(
    Map<String, dynamic> map,
  ) {
    return Chat(
      id: map['id'] as String,
      title: map['title'] as String,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
      messages: (map['messages'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(Message.fromMap)
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, title: $title, messages: ${messages.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.title == title &&
        other.createdAt == createdAt &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      createdAt,
      Object.hashAll(messages),
    );
  }
}