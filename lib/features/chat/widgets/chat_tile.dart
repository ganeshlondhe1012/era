import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../models/chat_menu_action.dart';
import 'chat_title_menu.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chat,
    required this.selected,
    required this.onTap,
    required this.onMenuSelected,
  });

  final Chat chat;
  final bool selected;
  final VoidCallback onTap;
  final ValueChanged<ChatMenuAction> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Colors.white10,

      leading: const Icon(
        Icons.chat_bubble_outline,
      ),

      title: Text(
        chat.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(
        '${chat.messageCount} messages',
        maxLines: 1,
      ),

      trailing: ChatTileMenu(
        onSelected: onMenuSelected,
      ),

      onTap: onTap,
    );
  }
}