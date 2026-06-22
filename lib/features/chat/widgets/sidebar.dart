import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        return Container(
          width: 260,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(
              right: BorderSide(
                color: Colors.grey.shade800,
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: controller.createNewChat,
                    icon: const Icon(Icons.add),
                    label: const Text("New Chat"),
                  ),
                ),
              ),

              const Divider(height: 1),

              Expanded(
                child: ListView.builder(
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    final chat = controller.chats[index];

                    final selected =
                        index == controller.currentChatIndex;

                    return ListTile(
                      leading: const Icon(Icons.chat_bubble_outline),

                      title: Text(
                        chat.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      selected: selected,

                      onTap: () {
                        controller.switchChat(index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}