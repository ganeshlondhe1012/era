import '../models/memory.dart';
import '../repository/local_repository.dart';

class MemoryService {
  MemoryService({
    required this._repository,
  });

  final LocalMemoryRepository _repository;

  final List<Memory> _memories = [];

  List<Memory> get memories => List.unmodifiable(_memories);

  Future<void> initialize() async {
    _memories
      ..clear()
      ..addAll(await _repository.load());
  }

  Future<void> addMemory({
    required String key,
    required String value,
  }) async {
    final existingIndex = _memories.indexWhere(
      (m) => m.key == key,
    );

    final memory = Memory(
  id: DateTime.now()
      .microsecondsSinceEpoch
      .toString(),
  key: key,
  value: value,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

    if (existingIndex == -1) {
      _memories.add(memory);
    } else {
      _memories[existingIndex] = memory;
    }

    await _repository.save(_memories);
  }

  Future<void> addMemories(
    Iterable<Memory> memories,
  ) async {
    for (final memory in memories) {
      final existingIndex = _memories.indexWhere(
        (m) => m.key == memory.key,
      );

      if (existingIndex == -1) {
        _memories.add(memory);
      } else {
        _memories[existingIndex] = memory;
      }
    }

    await _repository.save(_memories);
  }

  Future<void> removeMemory(String key) async {
    _memories.removeWhere((m) => m.key == key);

    await _repository.save(_memories);
  }

  Future<void> clear() async {
    _memories.clear();

    await _repository.save(_memories);
  }

  Memory? findMemory(String key) {
    try {
      return _memories.firstWhere(
        (m) => m.key == key,
      );
    } catch (_) {
      return null;
    }
  }

  List<Memory> search(String query) {
    final q = query.toLowerCase();

    return _memories.where((memory) {
      return memory.key.toLowerCase().contains(q) ||
          memory.value.toLowerCase().contains(q);
    }).toList();
  }
}