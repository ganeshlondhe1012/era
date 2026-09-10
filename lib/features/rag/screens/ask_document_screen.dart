
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ask_documents_controller.dart';
import '../../chat/controllers/chat_controller.dart';

class AskDocumentsScreen extends StatefulWidget {
  const AskDocumentsScreen({super.key});

  @override
  State<AskDocumentsScreen> createState() => _AskDocumentsScreenState();
}

class _AskDocumentsScreenState extends State<AskDocumentsScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isGenerating = false;
  String _response = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final question = _controller.text.trim();
    if (question.isEmpty || _isGenerating) return;

    final selectedModel = context.read<ChatController>().selectedModel;
    if (selectedModel == null) {
      setState(() => _response = 'No Ollama chat model is available. Start Ollama and install a model first.');
      return;
    }

    final ragController = context.read<AskDocumentsController>();

    setState(() {
      _response = '';
      _isGenerating = true;
    });

    try {
      final result = await ragController.query(
        question: question,
        model: selectedModel,
      );

      if (!mounted || result == null) return;

      setState(() {
        _response = result.answer;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _response = 'RAG error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AskDocumentsController>();
    final result = controller.result;

    return Scaffold(
      appBar: AppBar(title: const Text('Ask Documents')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _response.isEmpty
                          ? 'Ask a question about your imported documents.'
                          : _response,
                    ),
                    if (result != null && result.sources.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Retrieved sources',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...result.sources.map(
                        (source) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${source.documentName} • chunk ${source.chunkIndex + 1} • score ${source.score.toStringAsFixed(3)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (controller.isSearching) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about your documents...',
                    ),
                    onSubmitted: (_) => _ask(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _isGenerating ? null : _ask,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
