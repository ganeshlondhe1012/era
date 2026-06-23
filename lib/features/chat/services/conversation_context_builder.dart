import '../models/message.dart';

class ConversationContextBuilder {
  const ConversationContextBuilder();

  String build({
    required List<Message> messages,
    required String prompt,
    int maxMessages = 10,
  }) {
    final buffer = StringBuffer();

    final history = messages.length > maxMessages
        ? messages.sublist(
            messages.length - maxMessages,
          )
        : messages;

    if (history.isNotEmpty) {
      buffer.writeln('Conversation History:\n');

      for (final message in history) {
        buffer.writeln(
          '${message.isUser ? "User" : "Assistant"}: ${message.text}',
        );

        buffer.writeln();
      }
    }

    buffer.writeln('User:');
    buffer.writeln(prompt);

    return buffer.toString();
  }
}