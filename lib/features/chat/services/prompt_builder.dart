class PromptBuilder {
  const PromptBuilder();

  String build({
    required String userPrompt,
    Map<String, String> memories = const {},
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

      memories.forEach((key, value) {
        buffer.writeln('- $key: $value');
      });

      buffer.writeln();
    }

    buffer.writeln('User:');
    buffer.writeln(userPrompt);

    return buffer.toString().trim();
  }
}