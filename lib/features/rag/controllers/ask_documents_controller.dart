
import 'package:flutter/foundation.dart';

import '../models/document_chunk.dart';
import '../models/rag_query_result.dart';
import '../services/rag_pipeline.dart';

class AskDocumentsController extends ChangeNotifier {
  AskDocumentsController({required this._ragPipeline});

  final RagPipeline _ragPipeline;

  bool _isSearching = false;
  RagQueryResult? _result;
  String? _error;

  bool get isSearching => _isSearching;
  String? get error => _error;
  RagQueryResult? get result => _result;
  String get answer => _result?.answer ?? '';
  List<DocumentChunk> get retrievedChunks =>
      List.unmodifiable(_result?.chunks ?? const <DocumentChunk>[]);

  Future<RagQueryResult?> query({
    required String question,
    required String model,
  }) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty) return null;

    await _ragPipeline.ready;

    _isSearching = true;
    _error = null;
    notifyListeners();

    try {
      _result = await _ragPipeline.query(
        question: trimmed,
        model: model,
        topK: 5,
      );
      return _result;
    } catch (e) {
      _error = e.toString();
      _result = null;
      rethrow;
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clear() {
    _result = null;
    _error = null;
    notifyListeners();
  }
}
