import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';
import 'message_bubble.dart';

class ChatArea extends StatelessWidget {
  const ChatArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ChatController>(
        builder: (context, controller, child) {
          if (!controller.hasMessages) {
            return Container(
              color: const Color(0xFF121212),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 72,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Era',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your Offline AI Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Start a new conversation using the message box below.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            color: const Color(0xFF121212),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: controller.messages[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}