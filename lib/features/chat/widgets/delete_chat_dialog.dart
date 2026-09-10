import 'package:flutter/material.dart';

class DeleteChatDialog extends StatelessWidget {
  const DeleteChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_outline, color: Colors.red),
      title: const Text('Delete Conversation'),
      content: const Text('This conversation will be permanently removed.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
