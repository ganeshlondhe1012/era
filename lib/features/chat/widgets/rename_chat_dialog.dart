import 'package:flutter/material.dart';

class RenameChatDialog extends StatefulWidget {
  const RenameChatDialog({
    super.key,
    required this.initialTitle,
  });

  final String initialTitle;

  @override
  State<RenameChatDialog> createState() =>
      _RenameChatDialogState();
}

class _RenameChatDialogState
    extends State<RenameChatDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialTitle,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rename Chat'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Chat name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              _controller.text.trim(),
            );
          },
          child: const Text('Rename'),
        ),
      ],
    );
  }
}