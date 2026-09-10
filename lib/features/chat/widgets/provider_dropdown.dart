import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ai/controllers/ai_settings_controller.dart';
import '../../ai/models/ai_provider.dart';

class ProviderDropdown extends StatelessWidget {
  const ProviderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AISettingsController>(
      builder: (context, controller, _) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.smart_toy_outlined),

            title: const Text('AI Provider'),

            subtitle: const Text('Select the inference engine'),

            trailing: DropdownButton<AIProvider>(
              value: controller.settings.provider,

              underline: const SizedBox(),

              onChanged: (provider) {
                if (provider == null) return;

                controller.setProvider(provider);
              },

              items: AIProvider.values.map((provider) {
                return DropdownMenuItem(
                  value: provider,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        provider.isOffline ? Icons.computer : Icons.cloud,
                        size: 18,
                      ),

                      const SizedBox(width: 8),

                      Text(provider.displayName),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
