import 'package:flutter/foundation.dart';

import '../models/document_chunk.dart';
import '../services/rag_pipeline.dart';

class AskDocumentsController extends ChangeNotifier {
  AskDocumentsController({
    required RagPipeline ragPipeline,
  }) : _ragPipeline = ragPipeline;

  final RagPipeline _ragPipeline;

  bool _isSearching = false;

  List<DocumentChunk> _retrievedChunks = [];

  bool get isSearching => _isSearching;

  List<DocumentChunk> get retrievedChunks =>
      List.unmodifiable(_retrievedChunks);

  Future<void> search(
    String query,
  ) async {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _retrievedChunks =
          await _ragPipeline.retrieve(
        trimmed,
        limit: 5,
      );
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clear() {
    _retrievedChunks = [];
    notifyListeners();
  }
}