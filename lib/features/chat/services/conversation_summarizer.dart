import '../models/message.dart';

class ConversationSummarizer {
  const ConversationSummarizer();

  /// Returns a compact summary of older messages.
  ///
  /// V1 is rule-based.
  /// Later this can be replaced with an AI-generated summary.
  String summarize(
    List<Message> messages, {
    int keepLast = 10,
  }) {
    if (messages.length <= keepLast) {
      return '';
    }

    final oldMessages =
        messages.take(messages.length - keepLast);

    final buffer = StringBuffer();

    buffer.writeln(
      'Summary of previous conversation:',
    );
    buffer.writeln();

    for (final message in oldMessages) {
      buffer.writeln(
        '${message.isUser ? "User" : "Assistant"}: ${message.text}',
      );
    }

    return buffer.toString().trim();
  }
}