import '../models/memory.dart';

class MemoryExtractor {
  const MemoryExtractor();

  List<Memory> extract(String prompt) {
    final memories = <Memory>[];

    final text = prompt.trim();

    final lower = text.toLowerCase();

    if (lower.startsWith('my name is ')) {
      final value = text.substring(11).trim();

      if (value.isNotEmpty) {
        memories.add(
         Memory(
              id: DateTime.now()
                  .microsecondsSinceEpoch
                  .toString(),
              key: 'user_name',
              value: value,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
        );
      }
    }

    if (lower.startsWith('i am ')) {
      final value = text.substring(5).trim();

      if (value.isNotEmpty) {
        memories.add(
                  Memory(
            id: DateTime.now()
                .microsecondsSinceEpoch
                .toString(),
            key: 'user_name',
            value: value,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      }
    }

    if (lower.startsWith('i like ')) {
      final value = text.substring(7).trim();

      if (value.isNotEmpty) {
        memories.add(
                  Memory(
            id: DateTime.now()
                .microsecondsSinceEpoch
                .toString(),
            key: 'user_name',
            value: value,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      }
    }

    if (lower.startsWith('my favorite language is ')) {
      final value = text.substring(24).trim();

      if (value.isNotEmpty) {
        memories.add(
         Memory(
              id: DateTime.now()
                  .microsecondsSinceEpoch
                  .toString(),
              key: 'user_name',
              value: value,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
        );
      }
    }

    return memories;
  }
}