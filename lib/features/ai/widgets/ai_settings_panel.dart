import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ai_settings_controller.dart';
import '../../chat/widgets/provider_dropdown.dart';
import 'model_dropdown.dart';

class AISettingsPanel extends StatelessWidget {
  const AISettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AISettingsController>(
      builder: (context, controller, _) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'AI Settings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Text(
              'Configure the AI engine used by Era.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            const ProviderDropdown(),

            const SizedBox(height: 16),

            const ModelDropdown(),

            const SizedBox(height: 24),

            Card(
              child: SwitchListTile(
                title: const Text('Streaming Responses'),
                subtitle: const Text(
                  'Display responses token-by-token while the model generates.',
                ),
                value: controller.settings.streaming,
                onChanged: controller.setStreaming,
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.thermostat_outlined),
                title: const Text('Temperature'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: controller.settings.temperature,
                      min: 0.0,
                      max: 2.0,
                      divisions: 20,
                      label: controller.settings.temperature
                          .toStringAsFixed(1),
                      onChanged: controller.setTemperature,
                    ),
                    Text(
                      controller.settings.temperature
                          .toStringAsFixed(1),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.memory_outlined),
                title: const Text('Context Length'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: controller.settings.contextLength.toDouble(),
                      min: 1024,
                      max: 32768,
                      divisions: 31,
                      label:
                          controller.settings.contextLength.toString(),
                      onChanged: (value) {
                        controller.setContextLength(
                          value.round(),
                        );
                      },
                    ),
                    Text(
                      '${controller.settings.contextLength} tokens',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: Icon(
                  controller.providerAvailable
                      ? Icons.check_circle
                      : Icons.error_outline,
                  color: controller.providerAvailable
                      ? Colors.green
                      : Colors.red,
                ),
                title: const Text('Provider Status'),
                subtitle: Text(
                  controller.providerAvailable
                      ? 'Connected'
                      : 'Disconnected',
                ),
                trailing: FilledButton.icon(
                  onPressed: controller.refreshModels,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}