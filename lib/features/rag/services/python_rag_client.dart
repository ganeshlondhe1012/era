
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/document.dart';
import '../models/document_chunk.dart';
import '../models/rag_query_result.dart';

class PythonRagClient {
  PythonRagClient({
    http.Client? client,
    this.host = '127.0.0.1',
    this.port = 8787,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String host;
  final int port;

  Uri _uri(String path) => Uri.http('$host:$port', path);

  Future<bool> isAvailable() async {
    try {
      final response = await _client
          .get(_uri('/health'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>> health() async {
    final response = await _client
        .get(_uri('/health'))
        .timeout(const Duration(seconds: 5));
    return _decodeMap(response);
  }

  Future<DocumentIndexInfo> uploadDocument(Document document) async {
    final file = File(document.path);
    if (!await file.exists()) {
      throw Exception('Document file no longer exists: ${document.path}');
    }

    final request = http.MultipartRequest('POST', _uri('/documents/upload'));
    request.files.add(await http.MultipartFile.fromPath('file', document.path));

    final response = await request.send().timeout(const Duration(minutes: 5));
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('RAG service upload failed (${response.statusCode}): $body');
    }

    final json = jsonDecode(body);
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid RAG upload response.');
    }

    return DocumentIndexInfo.fromJson(json);
  }

  Future<List<DocumentIndexInfo>> getDocuments() async {
    final response = await _client
        .get(_uri('/documents'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Unable to read RAG documents: ${response.body}');
    }

    final json = jsonDecode(response.body);
    if (json is! List) {
      throw Exception('Invalid RAG document list response.');
    }

    return json
        .whereType<Map>()
        .map((item) => DocumentIndexInfo.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> deleteDocument(String documentId) async {
    final response = await _client
        .delete(_uri('/documents/${Uri.encodeComponent(documentId)}'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200 && response.statusCode != 404) {
      throw Exception('Unable to delete RAG document: ${response.body}');
    }
  }

  Future<void> clearDocuments() async {
    final response = await _client
        .delete(_uri('/documents'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Unable to clear RAG documents: ${response.body}');
    }
  }

  Future<RagQueryResult> query({
    required String question,
    required String model,
    int topK = 5,
  }) async {
    final response = await _client
        .post(
          _uri('/rag/query'),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'question': question,
            'model': model,
            'top_k': topK,
          }),
        )
        .timeout(const Duration(minutes: 5));

    if (response.statusCode != 200) {
      throw Exception('RAG query failed (${response.statusCode}): ${response.body}');
    }

    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid RAG query response.');
    }

    final sources = (json['sources'] as List? ?? [])
        .whereType<Map>()
        .map((item) => RagSource(
              documentId: item['document_id']?.toString() ?? '',
              documentName: item['document_name']?.toString() ?? '',
              chunkId: item['chunk_id']?.toString() ?? '',
              chunkIndex: (item['chunk_index'] as num?)?.toInt() ?? 0,
              score: (item['score'] as num?)?.toDouble() ?? 0,
            ))
        .toList();

    final chunks = <DocumentChunk>[];
    for (final source in sources) {
      // The Python MVP returns source metadata but not full chunk content.
      // The answer is already grounded by the Python service; chunks remain
      // optional UI metadata for future citation expansion.
      chunks.add(
        DocumentChunk(
          id: source.chunkId,
          documentId: source.documentId,
          index: source.chunkIndex,
          content: '[Retrieved by Python RAG: ${source.documentName}]',
        ),
      );
    }

    final answer = json['answer'];
    if (answer is! String || answer.trim().isEmpty) {
      throw Exception('RAG service returned an empty answer.');
    }

    return RagQueryResult(
      answer: answer,
      chunks: chunks,
      sources: sources,
    );
  }

  Map<String, dynamic> _decodeMap(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception('RAG service request failed (${response.statusCode}): ${response.body}');
    }
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid RAG service response.');
    }
    return json;
  }

  void dispose() => _client.close();
}

class DocumentIndexInfo {
  const DocumentIndexInfo({
    required this.id,
    required this.name,
    required this.size,
    required this.chunkCount,
    required this.embeddingModel,
  });

  final String id;
  final String name;
  final int size;
  final int chunkCount;
  final String embeddingModel;

  factory DocumentIndexInfo.fromJson(Map<String, dynamic> json) {
    return DocumentIndexInfo(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      size: (json['size'] as num?)?.toInt() ?? 0,
      chunkCount: (json['chunk_count'] as num?)?.toInt() ?? 0,
      embeddingModel: json['embedding_model']?.toString() ?? '',
    );
  }
}
