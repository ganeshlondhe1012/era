import '../models/document.dart';
import '../repository/document_repository.dart';

class DocumentService {
  DocumentService({
    required this._repository,
  });

  final DocumentRepository _repository;

  final List<Document> _documents = [];

  List<Document> get documents =>
      List.unmodifiable(_documents);

  Future<void> initialize() async {
    _documents
      ..clear()
      ..addAll(
        await _repository.loadDocuments(),
      );
  }

  Future<void> addDocument(
    Document document,
  ) async {
    final index = _documents.indexWhere(
      (d) => d.id == document.id,
    );

    if (index == -1) {
      _documents.add(document);
    } else {
      _documents[index] = document;
    }

    await _repository.upsert(document);
  }

  Future<void> removeDocument(
    String id,
  ) async {
    _documents.removeWhere(
      (d) => d.id == id,
    );

    await _repository.delete(id);
  }

  Future<void> clear() async {
    _documents.clear();

    await _repository.clear();
  }

  Document? findById(
    String id,
  ) {
    try {
      return _documents.firstWhere(
        (d) => d.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  List<Document> search(
    String query,
  ) {
    final q = query.toLowerCase();

    return _documents.where((document) {
      return document.name
              .toLowerCase()
              .contains(q) ||
          document.path
              .toLowerCase()
              .contains(q);
    }).toList();
  }

  bool contains(
    String id,
  ) {
    return _documents.any(
      (d) => d.id == id,
    );
  }

  int get count => _documents.length;

  bool get isEmpty => _documents.isEmpty;

  bool get isNotEmpty => _documents.isNotEmpty;
}