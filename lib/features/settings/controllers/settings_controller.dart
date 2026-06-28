import 'package:flutter/foundation.dart';

import '../models/app_settings.dart';
import '../services/settings_service.dart';

class SettingsController extends ChangeNotifier {
  SettingsController({SettingsService? service})
    : _service = service ?? SettingsService.instance;

  final SettingsService _service;

  AppSettings _settings = AppSettings.defaults;

  bool _initialized = false;

  bool _loading = false;

  AppSettings get settings => _settings;

  bool get initialized => _initialized;

  bool get isLoading => _loading;

  AppThemeMode get themeMode => _settings.themeMode;

  Future<void> initialize() async {
    if (_initialized) return;

    _loading = true;
    notifyListeners();

    _settings = await _service.loadSettings();

    _loading = false;
    _initialized = true;

    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_settings.themeMode == mode) return;

    _settings = _settings.copyWith(themeMode: mode);

    notifyListeners();

    await _service.saveSettings(_settings);
  }

  Future<void> resetSettings() async {
    _loading = true;

    notifyListeners();

    await _service.reset();

    _settings = AppSettings.defaults;

    _loading = false;

    notifyListeners();
  }

  Future<void> reload() async {
    _loading = true;

    notifyListeners();

    _settings = await _service.loadSettings();

    _loading = false;

    notifyListeners();
  }
}
