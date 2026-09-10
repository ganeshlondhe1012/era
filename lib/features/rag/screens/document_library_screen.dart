import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/document_controller.dart';

class DocumentLibraryScreen extends StatelessWidget {
  const DocumentLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Document Library'),
            actions: [
              IconButton(
                tooltip: 'Import document',
                onPressed: controller.isImporting
                    ? null
                    : () => _import(context, controller),
                icon: const Icon(Icons.upload_file),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${controller.documentCount} document(s) • ${controller.indexedChunks} indexed chunk(s)\nEmbeddings: Ollama/${'nomic-embed-text'}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              if (controller.isImporting) const LinearProgressIndicator(),
              Expanded(
                child: controller.hasDocuments
                    ? ListView.separated(
                        itemCount: controller.documentCount,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final document = controller.documents[index];
                          return ListTile(
                            leading: const Icon(Icons.description_outlined),
                            title: Text(
                              document.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              document.path,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              tooltip: 'Remove',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => controller.deleteDocument(document.id),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.folder_open, size: 72),
                              SizedBox(height: 16),
                              Text('No documents imported.'),
                              SizedBox(height: 8),
                              Text(
                                'Import a TXT or Markdown file to build the local RAG index.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.isImporting
                ? null
                : () => _import(context, controller),
            icon: const Icon(Icons.add),
            label: const Text('Import'),
          ),
        );
      },
    );
  }

  Future<void> _import(BuildContext context, DocumentController controller) async {
    try {
      await controller.importPickedDocument();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document indexed successfully.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    }
  }
}
