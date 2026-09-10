import 'package:flutter/material.dart';

import '../models/document_attachment.dart';

class AttachedDocumentCard extends StatelessWidget {
  const AttachedDocumentCard({
    super.key,
    required this.document,
    required this.onRemove,
  });

  final DocumentAttachment document;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.description_outlined, size: 32),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${document.characterCount} characters",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            IconButton(
              tooltip: "Remove document",
              onPressed: onRemove,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
