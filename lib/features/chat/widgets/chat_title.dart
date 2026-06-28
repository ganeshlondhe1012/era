import 'package:flutter/material.dart';

import '../models/chat.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chat,
    required this.selected,
    required this.onTap,
  });

  final Chat chat;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Colors.white10,
      leading: const Icon(Icons.chat_bubble_outline),
      title: Text(chat.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${chat.messageCount} messages', maxLines: 1),
      trailing: const Icon(Icons.more_horiz, size: 18),
      onTap: onTap,
    );
  }
}
