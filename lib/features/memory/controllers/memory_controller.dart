import 'package:flutter/foundation.dart';

import '../models/memory.dart';
import '../repository/local_repository.dart';
import '../services/memory_service.dart';

class MemoryController extends ChangeNotifier {
  MemoryController()
      : _service = MemoryService(
          repository: LocalMemoryRepository(),
        );

  final MemoryService _service;

  bool _initialized = false;

  bool get initialized => _initialized;

  List<Memory> get memories => _service.memories;

  Future<void> initialize() async {
    await _service.initialize();

    _initialized = true;

    notifyListeners();
  }

  Future<void> remember({
    required String key,
    required String value,
  }) async {
    await _service.addMemory(
      key: key,
      value: value,
    );

    notifyListeners();
  }

  Future<void> forget(
    String key,
  ) async {
    await _service.removeMemory(key);

    notifyListeners();
  }

  Future<void> clear() async {
    await _service.clear();

    notifyListeners();
  }

  Memory? getMemory(
    String key,
  ) {
    return _service.findMemory(key);
  }

  List<Memory> search(
    String query,
  ) {
    return _service.search(query);
  }
}