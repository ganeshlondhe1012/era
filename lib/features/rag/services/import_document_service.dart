
import '../models/document.dart';
import 'rag_pipeline.dart';

class ImportDocumentService {
  ImportDocumentService({required this._pipeline});

  final RagPipeline _pipeline;

  Future<Document> importDocument(Document document) async {
    if (!supports(document)) {
      throw UnsupportedError('Unsupported document type: ${document.path}');
    }

    // Python owns extraction, chunking, embeddings, persistence, retrieval,
    // and generation. Dart sends the selected file to the local RAG service.
    return _pipeline.indexDocument(document: document);
  }

  bool supports(Document document) {
    final lower = document.path.toLowerCase();
    return lower.endsWith('.txt') ||
        lower.endsWith('.md') ||
        lower.endsWith('.markdown');
  }

  List<String> supportedExtensions() => const ['.txt', '.md', '.markdown'];
}
