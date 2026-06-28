class SessionConfig {
  const SessionConfig({
    this.temperature = 0.7,
    this.maxTokens = 4096,
    this.stream = true,
  });

  final double temperature;

  final int maxTokens;

  final bool stream;
}