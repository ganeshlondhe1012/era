import 'package:flutter/foundation.dart';

/// Immutable response returned by any AI provider.
///
/// Every provider (Ollama, LM Studio, OpenAI, etc.)
/// must return this model.
@immutable
class AIResponse {
  /// Generated response text.
  final String text;

  /// Name of the model that generated the response.
  final String model;

  /// True when generation completed normally.
  ///
  /// Later this will help Auto-Continue detect
  /// incomplete responses.
  final bool completed;

  /// Time taken to generate the response.
  final Duration generationTime;

  /// Optional prompt token count.
  final int? promptTokens;

  /// Optional completion token count.
  final int? completionTokens;

  const AIResponse({
    required this.text,
    required this.model,
    required this.completed,
    required this.generationTime,
    this.promptTokens,
    this.completionTokens,
  });

  AIResponse copyWith({
    String? text,
    String? model,
    bool? completed,
    Duration? generationTime,
    int? promptTokens,
    int? completionTokens,
  }) {
    return AIResponse(
      text: text ?? this.text,
      model: model ?? this.model,
      completed: completed ?? this.completed,
      generationTime: generationTime ?? this.generationTime,
      promptTokens: promptTokens ?? this.promptTokens,
      completionTokens: completionTokens ?? this.completionTokens,
    );
  }

  bool get hasTokenUsage =>
      promptTokens != null || completionTokens != null;

  int? get totalTokens {
    if (promptTokens == null || completionTokens == null) {
      return null;
    }

    return promptTokens! + completionTokens!;
  }

  @override
  String toString() {
    return 'AIResponse('
        'model: $model, '
        'completed: $completed, '
        'generationTime: ${generationTime.inMilliseconds} ms'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AIResponse &&
        other.text == text &&
        other.model == model &&
        other.completed == completed &&
        other.generationTime == generationTime &&
        other.promptTokens == promptTokens &&
        other.completionTokens == completionTokens;
  }

  @override
  int get hashCode {
    return Object.hash(
      text,
      model,
      completed,
      generationTime,
      promptTokens,
      completionTokens,
    );
  }
}