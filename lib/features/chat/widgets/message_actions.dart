import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageActions extends StatelessWidget {
  const MessageActions({super.key, required this.text, this.onRegenerate});

  final String text;
  final VoidCallback? onRegenerate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Copy',
          icon: const Icon(Icons.copy_outlined, size: 18),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: text));

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
        ),

        IconButton(
          tooltip: 'Regenerate',
          icon: const Icon(Icons.refresh, size: 18),
          onPressed: onRegenerate,
        ),
      ],
    );
  }
}
