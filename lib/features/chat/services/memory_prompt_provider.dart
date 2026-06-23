import '../../memory/controllers/memory_controller.dart';

class MemoryPromptProvider {
  const MemoryPromptProvider({
    required MemoryController memoryController,
  }) : _memoryController = memoryController;

  final MemoryController _memoryController;

  Map<String, String> getRelevantMemories(
    String prompt,
  ) {
    final Map<String, String> result = {};

    // V1:
    // Return every stored memory.
    // Later this will become semantic search.
    for (final memory in _memoryController.memories) {
      result[memory.key] = memory.value;
    }

    return result;
  }
}