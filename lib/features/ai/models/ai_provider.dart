enum AIProvider {
  ollama,
  lmStudio,
  llamaCpp,
  openAI,
  gemini,
  claude,
}

extension AIProviderExtension on AIProvider {
  String get id {
    switch (this) {
      case AIProvider.ollama:
        return 'ollama';

      case AIProvider.lmStudio:
        return 'lmstudio';

      case AIProvider.llamaCpp:
        return 'llamacpp';

      case AIProvider.openAI:
        return 'openai';

      case AIProvider.gemini:
        return 'gemini';

      case AIProvider.claude:
        return 'claude';
    }
  }

  String get displayName {
    switch (this) {
      case AIProvider.ollama:
        return 'Ollama';

      case AIProvider.lmStudio:
        return 'LM Studio';

      case AIProvider.llamaCpp:
        return 'llama.cpp';

      case AIProvider.openAI:
        return 'OpenAI';

      case AIProvider.gemini:
        return 'Google Gemini';

      case AIProvider.claude:
        return 'Anthropic Claude';
    }
  }

  bool get isOffline {
    switch (this) {
      case AIProvider.ollama:
      case AIProvider.lmStudio:
      case AIProvider.llamaCpp:
        return true;

      case AIProvider.openAI:
      case AIProvider.gemini:
      case AIProvider.claude:
        return false;
    }
  }

  static AIProvider fromId(String id) {
    for (final provider in AIProvider.values) {
      if (provider.id == id) {
        return provider;
      }
    }

    return AIProvider.ollama;
  }
}