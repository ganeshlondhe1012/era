import '../models/document.dart';

abstract class DocumentRepository {
  /// Returns every indexed document.
  Future<List<Document>> loadDocuments();

  /// Saves the complete document collection.
  Future<void> saveDocuments(List<Document> documents);

  /// Removes every indexed document.
  Future<void> clear();

  /// Deletes a single document.
  Future<void> delete(String id);

  /// Adds or updates one document.
  Future<void> upsert(Document document);
}
