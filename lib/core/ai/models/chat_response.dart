class ChatResponse {
  const ChatResponse({
    required this.text,
    this.metadata = const {},
  });

  final String text;

  final Map<String, Object?> metadata;
}