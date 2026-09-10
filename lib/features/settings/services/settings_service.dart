import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';

class SettingsService {
  SettingsService._();

  static const String _settingsKey = 'era_app_settings';

  static final SettingsService instance = SettingsService._();

  SharedPreferences? _preferences;

  Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<AppSettings> loadSettings() async {
    await initialize();

    final jsonString = _preferences!.getString(_settingsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return AppSettings.defaults;
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJson(json);
    } catch (_) {
      return AppSettings.defaults;
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    await initialize();

    final jsonString = jsonEncode(settings.toJson());

    await _preferences!.setString(_settingsKey, jsonString);
  }

  Future<void> reset() async {
    await initialize();

    await _preferences!.remove(_settingsKey);
  }
}
