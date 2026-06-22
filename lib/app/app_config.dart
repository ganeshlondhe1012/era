class AppConfig {
  const AppConfig._();

  /// Ollama API endpoint.
  static const String ollamaBaseUrl = 'http://127.0.0.1:11434';

  /// Default model.
  static const String defaultModel = 'phi3:mini';

  /// API endpoint.
  static const String chatApi = '/api/chat';
}