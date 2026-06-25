import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings/screens/settings_screen.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_menu_action.dart';
import 'chat_search_bar.dart';
import 'chat_tile.dart';
import 'delete_chat_dialog.dart';
import 'rename_chat_dialog.dart';
import '../services/chat_export_service.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  static const double _width = 280;

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
               padding: const EdgeInsets.fromLTRB(
                          16,
                          20,
                          16,
                          12,
                        ),
                  child: SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () async {
                                  await controller.createNewChat();
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('New Chat'),
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                ),
                
               

                
                Padding(
            padding:
                const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    12,
                ),
            child:ChatSearchBar(
                  onChanged: controller.searchChats,
                ),),

                Expanded(
                 
                      child: ListView.builder(
                        padding:
                            const EdgeInsets.only(
                                top: 8,
                                bottom: 12,
                            ),
                    itemCount: controller.filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = controller.filteredChats[index];

                      final actualIndex =
                          controller.chats.indexOf(chat);

                      return ChatTile(
                        chat: chat,
                        selected:
                            controller.currentChatIndex ==
                                actualIndex,
                        onTap: () {
                          controller.switchChat(actualIndex);
                        },
                        onMenuSelected: (action) async {
                          switch (action) {
                            case ChatMenuAction.rename:
                              final title =
                                  await showDialog<String>(
                                context: context,
                                builder: (_) =>
                                    RenameChatDialog(
                                  initialTitle: chat.title,
                                ),
                              );

                              if (title != null &&
                                  title.trim().isNotEmpty) {
                                controller.switchChat(
                                  actualIndex,
                                );

                                await controller
                                    .renameCurrentChat(
                                  title,
                                );
                              }
                              break;

                            case ChatMenuAction.delete:
                              final confirmed =
                                  await showDialog<bool>(
                                context: context,
                                builder: (_) =>
                                    const DeleteChatDialog(),
                              );

                              if (confirmed == true) {
                                controller.switchChat(
                                  actualIndex,
                                );

                                await controller
                                    .deleteCurrentChat();

                                if (context.mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Conversation deleted',
                                      ),
                                      action:
                                          SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // TODO: Implement undo.
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                              break;

                            case ChatMenuAction.pin:
                            case ChatMenuAction.duplicate:
                           case ChatMenuAction.export:
                                try {
                                  controller.switchChat(actualIndex);

                                  final exporter = const ChatExportService();

                                  final file = await exporter.exportMarkdown(
                                    controller.currentChat,
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Exported to:\n${file.path}',
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Export failed: $e',
                                        ),
                                      ),
                                    );
                                  }
                                }
                                break;
                          }
                        },
                      );
                    },
                  ),
                  ),
                

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
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