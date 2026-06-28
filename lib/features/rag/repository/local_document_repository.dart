import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/document.dart';
import 'document_repository.dart';

class LocalDocumentRepository implements DocumentRepository {
  static const String _storageKey = 'era_documents';

  @override
  Future<List<Document>> loadDocuments() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_storageKey);

    if (json == null || json.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(json);

    return decoded
        .cast<Map<String, dynamic>>()
        .map(
          (e) => Document(
            id: e['id'] as String,
            name: e['name'] as String,
            path: e['path'] as String,
            size: e['size'] as int,
            createdAt: DateTime.parse(e['createdAt'] as String),
          ),
        )
        .toList();
  }

  @override
  Future<void> saveDocuments(List<Document> documents) async {
    final prefs = await SharedPreferences.getInstance();

    final json = documents
        .map(
          (d) => {
            'id': d.id,
            'name': d.name,
            'path': d.path,
            'size': d.size,
            'createdAt': d.createdAt.toIso8601String(),
          },
        )
        .toList();

    await prefs.setString(_storageKey, jsonEncode(json));
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_storageKey);
  }

  @override
  Future<void> delete(String id) async {
    final docs = await loadDocuments();

    docs.removeWhere((doc) => doc.id == id);

    await saveDocuments(docs);
  }

  @override
  Future<void> upsert(Document document) async {
    final docs = await loadDocuments();

    final index = docs.indexWhere((d) => d.id == document.id);

    if (index == -1) {
      docs.add(document);
    } else {
      docs[index] = document;
    }

    await saveDocuments(docs);
  }
}
