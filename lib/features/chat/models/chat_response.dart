import 'package:flutter/foundation.dart';

@immutable
class ChatResponse {
  const ChatResponse({
    required this.text,
    required this.completed,
    this.error,
    this.tokens,
    this.generationTime,
  });

  final String text;

  final bool completed;

  final String? error;

  final int? tokens;

  final Duration? generationTime;

  bool get hasError => error != null;

  ChatResponse copyWith({
    String? text,
    bool? completed,
    String? error,
    int? tokens,
    Duration? generationTime,
  }) {
    return ChatResponse(
      text: text ?? this.text,
      completed: completed ?? this.completed,
      error: error ?? this.error,
      tokens: tokens ?? this.tokens,
      generationTime:
          generationTime ?? this.generationTime,
    );
  }
}