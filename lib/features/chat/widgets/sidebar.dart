import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings/screens/settings_screen.dart';
import '../controllers/chat_controller.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  static const double _width = 260;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: SafeArea(
        child: Consumer<ChatController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: controller.createNewChat,
                      icon: const Icon(Icons.add),
                      label: const Text('New Chat'),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) {
                      final chat = controller.chats[index];

                      return ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: Text(
                          chat.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        selected:
                            controller.currentChatIndex == index,
                        onTap: () {
                          controller.switchChat(index);
                        },
                      );
                    },
                  ),
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}