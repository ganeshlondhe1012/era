import 'package:flutter/foundation.dart';

/// ===============================================================
/// Era Base Controller
///
/// Every application controller should extend this class.
///
/// Examples:
/// - ThemeController
/// - WindowController
/// - SettingsController
/// - PluginController
/// - ChatController
/// - AgentController
///
/// Future:
/// - Busy state
/// - Error state
/// - Lifecycle
/// - Logging
/// - Analytics
/// ===============================================================
abstract class AppController extends ChangeNotifier {
  bool _initialized = false;

  bool get isInitialized => _initialized;

  @protected
  void markInitialized() {
    if (_initialized) {
      return;
    }

    _initialized = true;
    notifyListeners();
  }

  @protected
  void notifyStateChanged() {
    if (!hasListeners) {
      return;
    }

    notifyListeners();
  }

  @mustCallSuper
  Future<void> initialize() async {
    markInitialized();
  }

  @mustCallSuper
  Future<void> disposeController() async {}
}
