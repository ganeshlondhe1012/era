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
          selectedTileColor:
              Theme.of(context).colorScheme.primaryContainer,

          tileColor: chat.isPinned
              ? Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.15)
              : null,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          leading: Icon(
            chat.isPinned
                ? Icons.push_pin
                : Icons.chat_bubble_outline,
            color: chat.isPinned
                ? Theme.of(context).colorScheme.primary
                : null,
          ),

          title: Row(
            children: [
              if (chat.isPinned)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Transform.rotate(
                    angle: -0.6,
                    child: Icon(
                      Icons.push_pin,
                      size: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                ),

              Expanded(
                child: Text(
                  chat.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: chat.isPinned
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
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