class AIResponseChunk {
  const AIResponseChunk({required this.text, this.isDone = false});

  final String text;

  final bool isDone;

  AIResponseChunk copyWith({String? text, bool? isDone}) {
    return AIResponseChunk(
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }
}
