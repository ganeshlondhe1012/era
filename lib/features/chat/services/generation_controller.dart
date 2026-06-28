import 'dart:async';

/// Controls the lifecycle of a streaming generation.
///
/// V1:
/// - Start
/// - Cancel
/// - Check cancellation state
///
/// Future:
/// - Pause
/// - Resume
/// - Retry
/// - Timeout
class GenerationController {
  bool _cancelled = false;

  final StreamController<void> _cancelController =
      StreamController<void>.broadcast();

  /// Emits once when generation is cancelled.
  Stream<void> get onCancel => _cancelController.stream;

  bool get isCancelled => _cancelled;

  void reset() {
    _cancelled = false;
  }

  void cancel() {
    if (_cancelled) {
      return;
    }

    _cancelled = true;

    if (!_cancelController.isClosed) {
      _cancelController.add(null);
    }
  }

  void dispose() {
    _cancelController.close();
  }
}
