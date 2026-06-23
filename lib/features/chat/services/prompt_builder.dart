import '../../memory/models/memory.dart';

class PromptBuilder {
  const PromptBuilder();

  String build({
    required String userPrompt,
    List<Memory> memories = const [],
    String? systemPrompt,
  }) {
    final buffer = StringBuffer();

    if (systemPrompt != null &&
        systemPrompt.trim().isNotEmpty) {
      buffer.writeln(systemPrompt);
      buffer.writeln();
    }

    if (memories.isNotEmpty) {
      buffer.writeln(
        'Relevant user memory:',
      );

      buffer.writeln();

      for (final memory in memories) {
        buffer.writeln(
          '- ${memory.key}: ${memory.value}',
        );
      }

      buffer.writeln();
    }

    buffer.writeln('User:');
    buffer.writeln(userPrompt);

    return buffer.toString().trim();
  }
}