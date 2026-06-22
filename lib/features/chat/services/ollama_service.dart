import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class OllamaService {
  OllamaService({
    http.Client? client,
    this.host = '127.0.0.1',
    this.port = 11434,
    this.requestTimeout = const Duration(minutes: 2),
  }) : _client = client ?? http.Client();

  final http.Client _client;

  final String host;
  final int port;
  final Duration requestTimeout;

  Uri get _tagsUri => Uri.http('$host:$port', '/api/tags');

  Uri get _chatUri => Uri.http('$host:$port', '/api/chat');

  /// Returns true when the local Ollama server is running.
  Future<bool> isAvailable() async {
    try {
      final response = await _client
          .get(_tagsUri)
          .timeout(const Duration(seconds: 3));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Sends a prompt to Ollama and returns the complete response.
  Future<String> generateResponse({
    required String prompt,
    required String model,
  }) async {
    final response = await _client
        .post(
          _chatUri,
          headers: const {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': model,
            'stream': false,
            'messages': [
              {
                'role': 'user',
                'content': prompt,
              }
            ],
          }),
        )
        .timeout(requestTimeout);

    if (response.statusCode != 200) {
      throw Exception(
        'Ollama returned HTTP ${response.statusCode}\n${response.body}',
      );
    }

    final dynamic json = jsonDecode(response.body);

    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid response received from Ollama.');
    }

    final message = json['message'];

    if (message is! Map<String, dynamic>) {
      throw Exception('Missing message object.');
    }

    final content = message['content'];

    if (content is! String || content.trim().isEmpty) {
      throw Exception('Empty response received from Ollama.');
    }

    return content.trim();
  }

  /// Returns installed local models.
  Future<List<String>> getInstalledModels() async {
    final response = await _client
        .get(_tagsUri)
        .timeout(const Duration(seconds: 5));

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to fetch installed models.',
      );
    }

    final dynamic json = jsonDecode(response.body);

    if (json is! Map<String, dynamic>) {
      return [];
    }

    final models = json['models'];

    if (models is! List) {
      return [];
    }

    return models
        .whereType<Map>()
        .map((e) => e['name'])
        .whereType<String>()
        .toList();
  }

  void dispose() {
    _client.close();
  }
}