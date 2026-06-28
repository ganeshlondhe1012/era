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

  Widget _buildHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      20,
      20,
      20,
      16,
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer,
            borderRadius:
                BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Theme.of(context)
                .colorScheme
                .primary,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "Era",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
              ),

              Text(
                "Local AI Assistant",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  
  Widget _buildNewChatButton(
  ChatController controller,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    child: SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: controller.createNewChat,
        icon: const Icon(Icons.add),
        label: const Text("New Chat"),
        style: FilledButton.styleFrom(
          minimumSize:
              const Size.fromHeight(50),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildSearch(
  BuildContext context,
  ChatController controller,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      16,
      16,
      16,
      12,
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
            bottom: 8,
          ),
          child: Text(
            "SEARCH",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(
                  letterSpacing: 1.2,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
          ),
        ),

        ChatSearchBar(
          onChanged:
              controller.searchChats,
        ),
      ],
    ),
  );
}

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
              _buildHeader(context),

              _buildNewChatButton(controller),

              _buildSearch(
                context,
                controller,
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    4,
                    12,
                    12,
                  ),
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 4),
                  itemCount:
                      controller.filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat =
                        controller.filteredChats[index];

                    final actualIndex =
                        controller.chats.indexOf(chat);

                    return ChatTile(
                      chat: chat,
                      selected:
                          controller.currentChatIndex ==
                              actualIndex,
                      onTap: () {
                        controller.switchChat(
                          actualIndex,
                        );
                      },
                      onMenuSelected:
                          (action) async {
                        switch (action) {
                          case ChatMenuAction.rename:
                            final title =
                                await showDialog<String>(
                              context: context,
                              builder: (_) =>
                                  RenameChatDialog(
                                initialTitle:
                                    chat.title,
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

                          case ChatMenuAction.pin:
                            await controller
                                .togglePin(chat.id);
                            break;

                          case ChatMenuAction.duplicate:
                            await controller
                                .duplicateChat(chat.id);
                            break;

                          case ChatMenuAction.export:
                            try {
                              controller.switchChat(
                                actualIndex,
                              );

                              final exporter =
                                  const ChatExportService();

                              final file =
                                  await exporter
                                      .exportMarkdown(
                                controller.currentChat,
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Exported to:\n${file.path}',
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Export failed: $e',
                                    ),
                                  ),
                                );
                              }
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
                                  const SnackBar(
                                    content: Text(
                                      'Conversation deleted',
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

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Divider(
                  color: Theme.of(context)
                      .dividerColor,
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.settings_outlined,
                ),
                title: const Text(
                  'Settings',
                ),
                subtitle: const Text(
                  'Era v0.1.0',
                ),
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
}}