import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/ai_settings.dart';

class AISettingsService {
  AISettingsService._();

  static const String _storageKey = 'era_ai_settings';

  static final AISettingsService instance =
      AISettingsService._();

  SharedPreferences? _preferences;

  Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<AISettings> loadSettings() async {
    await initialize();

    final jsonString =
        _preferences!.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return AISettings.defaults;
    }

    try {
      final json =
          jsonDecode(jsonString) as Map<String, dynamic>;

      return AISettings.fromJson(json);
    } catch (_) {
      return AISettings.defaults;
    }
  }

  Future<void> saveSettings(
    AISettings settings,
  ) async {
    await initialize();

    final jsonString =
        jsonEncode(settings.toJson());

    await _preferences!.setString(
      _storageKey,
      jsonString,
    );
  }

  Future<void> reset() async {
    await initialize();

    await _preferences!.remove(_storageKey);
  }
}