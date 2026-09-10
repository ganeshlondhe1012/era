import 'package:flutter/foundation.dart';

import '../../chat/services/ollama_service.dart';

import '../models/ai_provider.dart';
import '../models/ai_settings.dart';
import '../services/ai_settings_service.dart';

class AISettingsController extends ChangeNotifier {
  AISettingsController({
    AISettingsService? settingsService,
    OllamaService? ollamaService,
  }) : _settingsService = settingsService ?? AISettingsService.instance,
       _ollamaService = ollamaService ?? OllamaService();

  final AISettingsService _settingsService;
  final OllamaService _ollamaService;

  AISettings _settings = AISettings.defaults;

  bool _loading = false;

  bool _initialized = false;

  bool _providerAvailable = false;

  List<String> _availableModels = [];

  AISettings get settings => _settings;

  bool get isLoading => _loading;

  bool get initialized => _initialized;

  bool get providerAvailable => _providerAvailable;

  List<String> get availableModels => List.unmodifiable(_availableModels);

  Future<void> initialize() async {
    if (_initialized) return;

    _loading = true;
    notifyListeners();

    _settings = await _settingsService.loadSettings();

    await refreshModels();

    _loading = false;
    _initialized = true;

    notifyListeners();
  }

  Future<void> refreshModels() async {
    try {
      switch (_settings.provider) {
        case AIProvider.ollama:
          _providerAvailable = await _ollamaService.isAvailable();

          if (_providerAvailable) {
            _availableModels = await _ollamaService.getInstalledModels();

            if (_settings.model.isEmpty && _availableModels.isNotEmpty) {
              _settings = _settings.copyWith(model: _availableModels.first);
            }
          } else {
            _availableModels = [];
          }

          break;

        default:
          _providerAvailable = false;
          _availableModels = [];
      }
    } catch (_) {
      _providerAvailable = false;
      _availableModels = [];
    }

    notifyListeners();
  }

  Future<void> setProvider(AIProvider provider) async {
    if (_settings.provider == provider) return;

    _settings = _settings.copyWith(provider: provider, model: '');

    await _settingsService.saveSettings(_settings);

    await refreshModels();

    notifyListeners();
  }

  Future<void> setModel(String model) async {
    if (_settings.model == model) return;

    _settings = _settings.copyWith(model: model);

    await _settingsService.saveSettings(_settings);

    notifyListeners();
  }

  Future<void> setTemperature(double value) async {
    _settings = _settings.copyWith(temperature: value);

    await _settingsService.saveSettings(_settings);

    notifyListeners();
  }

  Future<void> setStreaming(bool enabled) async {
    _settings = _settings.copyWith(streaming: enabled);

    await _settingsService.saveSettings(_settings);

    notifyListeners();
  }

  Future<void> setContextLength(int length) async {
    _settings = _settings.copyWith(contextLength: length);

    await _settingsService.saveSettings(_settings);

    notifyListeners();
  }

  Future<void> reset() async {
    await _settingsService.reset();

    _settings = AISettings.defaults;

    await refreshModels();

    notifyListeners();
  }
}
