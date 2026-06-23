import 'ai_provider.dart';

class AISettings {
  const AISettings({
    required this.provider,
    required this.model,
    required this.temperature,
    required this.topP,
    required this.contextLength,
    required this.streaming,
    required this.keepAliveMinutes,
  });

  final AIProvider provider;

  final String model;

  final double temperature;

  final double topP;

  final int contextLength;

  final bool streaming;

  final int keepAliveMinutes;

  static const defaults = AISettings(
    provider: AIProvider.ollama,
    model: '',
    temperature: 0.7,
    topP: 0.9,
    contextLength: 4096,
    streaming: true,
    keepAliveMinutes: 5,
  );

  AISettings copyWith({
    AIProvider? provider,
    String? model,
    double? temperature,
    double? topP,
    int? contextLength,
    bool? streaming,
    int? keepAliveMinutes,
  }) {
    return AISettings(
      provider: provider ?? this.provider,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      contextLength: contextLength ?? this.contextLength,
      streaming: streaming ?? this.streaming,
      keepAliveMinutes:
          keepAliveMinutes ?? this.keepAliveMinutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider.id,
      'model': model,
      'temperature': temperature,
      'topP': topP,
      'contextLength': contextLength,
      'streaming': streaming,
      'keepAliveMinutes': keepAliveMinutes,
    };
  }

  factory AISettings.fromJson(
    Map<String, dynamic> json,
  ) {
    return AISettings(
      provider: AIProviderExtension.fromId(
        json['provider']?.toString() ?? 'ollama',
      ),
      model: json['model']?.toString() ?? '',
      temperature:
          (json['temperature'] as num?)?.toDouble() ?? 0.7,
      topP:
          (json['topP'] as num?)?.toDouble() ?? 0.9,
      contextLength:
          (json['contextLength'] as num?)?.toInt() ??
              4096,
      streaming:
          json['streaming'] as bool? ?? true,
      keepAliveMinutes:
          (json['keepAliveMinutes'] as num?)?.toInt() ??
              5,
    );
  }
}