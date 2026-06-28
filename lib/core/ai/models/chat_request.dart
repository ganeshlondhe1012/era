class ChatRequest {
  const ChatRequest({
    required this.text,
    this.sessionId,
    this.attachments = const [],
    this.metadata = const {},
  });

  final String text;

  final String? sessionId;

  final List<Object> attachments;

  final Map<String, Object?> metadata;
}