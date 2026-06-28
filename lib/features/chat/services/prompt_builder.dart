import 'context/chat_context.dart';

class PromptBuilder {
  const PromptBuilder();

  String build(
    ChatContext context,
  ) {
    final buffer = StringBuffer();

    // Future system prompt
    if (context.hasSystemPrompt) {
      buffer.writeln(context.systemPrompt);
      buffer.writeln();
    }

    // Future conversation history
    if (context.hasHistory) {
      // keep existing history formatting here
    }

    // Future memory
    if (context.hasMemories) {
      // keep existing memory formatting here
    }

    // Future documents
    if (context.hasDocuments) {
      // placeholder
    }

    buffer.write(context.userPrompt);

    return buffer.toString().trim();
  }
}