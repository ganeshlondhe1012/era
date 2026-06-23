import '../models/memory.dart';
import '../repository/memory_repository.dart';

class MemoryService {
  MemoryService({
    required MemoryRepository repository,
  }) : _repository = repository;

  final MemoryRepository _repository;

  final List<Memory> _memories = [];

  List<Memory> get memories =>
      List.unmodifiable(_memories);

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
      (memory) => memory.key == key,
    );

    if (existingIndex != -1) {
      _memories[existingIndex] =
          _memories[existingIndex].copyWith(
        value: value,
        updatedAt: DateTime.now(),
      );
    } else {
      _memories.add(
        Memory(
          id: DateTime.now()
              .microsecondsSinceEpoch
              .toString(),
          key: key,
          value: value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }

    await _repository.save(_memories);
  }

  Future<void> removeMemory(
    String key,
  ) async {
    _memories.removeWhere(
      (memory) => memory.key == key,
    );

    await _repository.save(_memories);
  }

  Future<void> clear() async {
    _memories.clear();

    await _repository.clear();
  }

  Memory? findMemory(
    String key,
  ) {
    try {
      return _memories.firstWhere(
        (memory) => memory.key == key,
      );
    } catch (_) {
      return null;
    }
  }

  List<Memory> search(
    String query,
  ) {
    final search = query.toLowerCase();

    return _memories.where((memory) {
      return memory.key
              .toLowerCase()
              .contains(search) ||
          memory.value
              .toLowerCase()
              .contains(search);
    }).toList();
  }
}