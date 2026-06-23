import 'package:flutter/foundation.dart';

@immutable
class ChatRequest {
  const ChatRequest({
    required this.prompt,
    required this.model,
  });

  final String prompt;
  final String model;

  ChatRequest copyWith({
    String? prompt,
    String? model,
  }) {
    return ChatRequest(
      prompt: prompt ?? this.prompt,
      model: model ?? this.model,
    );
  }
}