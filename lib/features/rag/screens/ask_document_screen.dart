import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ask_documents_controller.dart';
import '../services/rag_chat_service.dart';

class AskDocumentsScreen extends StatefulWidget {
  const AskDocumentsScreen({super.key});

  @override
  State<AskDocumentsScreen> createState() =>
      _AskDocumentsScreenState();
}

class _AskDocumentsScreenState
    extends State<AskDocumentsScreen> {
  final TextEditingController _controller =
      TextEditingController();

  String _response = '';

  bool _isGenerating = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final question = _controller.text.trim();

    if (question.isEmpty) {
      return;
    }

    final ragController =
        context.read<AskDocumentsController>();

    final ragChat =
        context.read<RagChatService>();

    setState(() {
      _response = '';
      _isGenerating = true;
    });

    try {
      await ragController.search(question);

      final chunks =
          ragController.retrievedChunks;

      await for (final chunk in ragChat.streamAnswer(
        model: 'phi3:mini',
        question: question,
        chunks: chunks,
      )) {
        setState(() {
          _response += chunk.text;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        context.watch<AskDocumentsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ask Documents',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Text(
                  _response.isEmpty
                      ? 'Ask a question about your imported documents.'
                      : _response,
                ),
              ),
            ),
          ),
          if (controller.isSearching)
            const LinearProgressIndicator(),
          Padding(
            padding:
                const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(
                      hintText:
                          'Ask about your documents...',
                    ),
                    onSubmitted: (_) => _ask(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed:
                      _isGenerating
                          ? null
                          : _ask,
                  child: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}