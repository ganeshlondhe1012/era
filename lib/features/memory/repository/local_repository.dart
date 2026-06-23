import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/memory.dart';
import 'memory_repository.dart';

class LocalMemoryRepository implements MemoryRepository {
  static const String _storageKey = 'era_memory';

  @override
  Future<List<Memory>> load() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_storageKey);

    if (json == null || json.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(json);

    return decoded
        .cast<Map<String, dynamic>>()
        .map(Memory.fromMap)
        .toList();
  }

  @override
  Future<void> save(
    List<Memory> memories,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final json = memories
        .map((memory) => memory.toMap())
        .toList();

    await prefs.setString(
      _storageKey,
      jsonEncode(json),
    );
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_storageKey);
  }
}