import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/settings_controller.dart';
import '../models/app_settings.dart';
import '../models/settings_category.dart';

import '../../ai/widgets/ai_settings_panel.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
    required this.category,
  });

  final SettingsCategory category;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case SettingsCategory.appearance:
        return const _AppearanceSettings();

     case SettingsCategory.ai:
  return const AISettingsPanel();

      case SettingsCategory.chat:
        return const _ComingSoon(
          title: 'Chat Settings',
          description:
              'Customize chat appearance, markdown, code blocks and message behavior.',
        );

      case SettingsCategory.memory:
        return const _ComingSoon(
          title: 'Memory Settings',
          description:
              'Manage long-term memory, summaries and knowledge storage.',
        );

      case SettingsCategory.voice:
        return const _ComingSoon(
          title: 'Voice Settings',
          description:
              'Configure speech recognition and text-to-speech.',
        );

      case SettingsCategory.privacy:
        return const _ComingSoon(
          title: 'Privacy',
          description:
              'Manage telemetry, offline mode and security options.',
        );

      case SettingsCategory.advanced:
        return const _ComingSoon(
          title: 'Advanced',
          description:
              'Developer tools, logs and experimental features.',
        );
    }
  }
}

class _AppearanceSettings extends StatelessWidget {
  const _AppearanceSettings();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, controller, _)  {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Text(
              'Customize the look and feel of Era.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            Card(
              child: ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('Application Theme'),
                subtitle: const Text(
                  'Choose the overall appearance of Era.',
                ),
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

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction_outlined,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}