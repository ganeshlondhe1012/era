import '../models/memory.dart';

abstract class MemoryRepository {
  Future<List<Memory>> load();

  Future<void> save(
    List<Memory> memories,
  );

  Future<void> clear();
}