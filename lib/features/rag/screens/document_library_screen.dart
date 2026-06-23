import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/document_controller.dart';

class DocumentLibraryScreen extends StatelessWidget {
  const DocumentLibraryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Document Library',
            ),
            actions: [
              IconButton(
                tooltip: 'Import Document',
                onPressed: () {
                  // File picker integration comes next.
                },
                icon: const Icon(
                  Icons.upload_file,
                ),
              ),
            ],
          ),
          body: controller.hasDocuments
              ? ListView.separated(
                  itemCount: controller.documentCount,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final document =
                        controller.documents[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.description_outlined,
                      ),
                      title: Text(
                        document.name,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        document.path,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                        onPressed: () {
                          controller.deleteDocument(
                            document.id,
                          );
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 72,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No documents imported.',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Import TXT or Markdown files to start using RAG.',
                        textAlign:
                            TextAlign.center,
                      ),
                    ],
                  ),
                ),
          floatingActionButton:
              FloatingActionButton.extended(
            onPressed: () {
              // File picker comes next.
            },
            icon: const Icon(
              Icons.add,
            ),
            label: const Text(
              'Import',
            ),
          ),
        );
      },
    );
  }
}