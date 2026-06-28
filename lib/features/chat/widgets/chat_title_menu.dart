import 'package:flutter/material.dart';

import '../models/chat_menu_action.dart';

class ChatTileMenu extends StatelessWidget {
  const ChatTileMenu({super.key, required this.onSelected});

  final ValueChanged<ChatMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ChatMenuAction>(
      tooltip: 'Conversation actions',
      onSelected: onSelected,
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: ChatMenuAction.rename,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Rename'),
          ),
        ),
        PopupMenuItem(
          value: ChatMenuAction.pin,
          child: ListTile(
            leading: Icon(Icons.push_pin_outlined),
            title: Text('Pin'),
          ),
        ),
        PopupMenuItem(
          value: ChatMenuAction.duplicate,
          child: ListTile(
            leading: Icon(Icons.copy_outlined),
            title: Text('Duplicate'),
          ),
        ),
        PopupMenuItem(
          value: ChatMenuAction.export,
          child: ListTile(
            leading: Icon(Icons.download_outlined),
            title: Text('Export'),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: ChatMenuAction.delete,
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}
