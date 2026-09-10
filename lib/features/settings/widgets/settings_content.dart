import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/settings_controller.dart';
import '../models/app_settings.dart';
import '../models/settings_category.dart';

import '../../chat/controllers/chat_controller.dart';

import '../../ai/widgets/ai_settings_panel.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key, required this.category});

  final SettingsCategory category;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case SettingsCategory.appearance:
        return const _GeneralSettings();

      case SettingsCategory.ai:
        return const AISettingsPanel();

      case SettingsCategory.chat:
        return const _ChatSettings();
    }
  }
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, controller, _) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('General', style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 8),

            Text(
              'General application preferences.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            Card(
              child: ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('Application Theme'),
                subtitle: const Text('Choose the overall appearance of Era.'),
                trailing: DropdownButton<AppThemeMode>(
                  value: controller.themeMode,
                  underline: const SizedBox(),
                  onChanged: (mode) {
                    if (mode != null) {
                      controller.setThemeMode(mode);
                    }
                  },
                  items: AppThemeMode.values.map((mode) {
                    return DropdownMenuItem<AppThemeMode>(
                      value: mode,
                      child: Text(_themeName(mode)),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Card(
              child: ListTile(
                enabled: false,
                leading: Icon(Icons.color_lens_outlined),
                title: Text('Accent Color'),
                subtitle: Text('Coming soon'),
              ),
            ),

            const SizedBox(height: 16),

            const Card(
              child: ListTile(
                enabled: false,
                leading: Icon(Icons.text_fields),
                title: Text('Font Size'),
                subtitle: Text('Coming soon'),
              ),
            ),
          ],
        );
      },
    );
  }

  String _themeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.oled:
        return 'OLED';
      case AppThemeMode.midnight:
        return 'Midnight';
      case AppThemeMode.dracula:
        return 'Dracula';
      case AppThemeMode.nord:
        return 'Nord';
      case AppThemeMode.gruvbox:
        return 'Gruvbox';
      case AppThemeMode.oneDark:
        return 'One Dark';
      case AppThemeMode.custom:
        return 'Custom';
    }
  }
}

class _ChatSettings extends StatelessWidget {
  const _ChatSettings();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, _) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Chat', style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 8),

            Text(
              'Manage conversations and chat data.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            //------------------------------------------------------------------
            // Conversation
            //------------------------------------------------------------------
            Card(
              child: ListTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text('Clear All Chats'),
                subtitle: const Text(
                  'Delete every conversation stored in Era.',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete All Chats'),
                        content: const Text('This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm != true) {
                    return;
                  }

                  await controller.clearAllChats();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All chats deleted.')),
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 16),

            //------------------------------------------------------------------
            // Export
            //------------------------------------------------------------------
            Card(
              child: ListTile(
                leading: const Icon(Icons.upload_file_outlined),
                title: const Text('Export All Chats'),
                subtitle: const Text('Export every conversation as Markdown.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await controller.exportAllChats();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Chats exported successfully.'),
                      ),
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 16),

            //------------------------------------------------------------------
            // Backup
            //------------------------------------------------------------------
            const Card(
              child: ListTile(
                enabled: false,
                leading: Icon(Icons.backup_outlined),
                title: Text('Backup Chats'),
                subtitle: Text('Coming soon'),
              ),
            ),

            const SizedBox(height: 16),

            //------------------------------------------------------------------
            // Cache
            //------------------------------------------------------------------
            const Card(
              child: ListTile(
                enabled: false,
                leading: Icon(Icons.cleaning_services_outlined),
                title: Text('Clear Temporary Cache'),
                subtitle: Text('Coming soon'),
              ),
            ),

            const SizedBox(height: 32),

            //------------------------------------------------------------------
            // Statistics
            //------------------------------------------------------------------
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Conversations'),
                    trailing: Text(controller.totalChats.toString()),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Messages'),
                    trailing: Text(controller.totalMessages.toString()),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Storage Used'),
                    trailing: Text(controller.estimatedStorage),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
