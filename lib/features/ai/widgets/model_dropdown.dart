import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ai_settings_controller.dart';

class ModelDropdown extends StatelessWidget {
  const ModelDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AISettingsController>(
      builder: (context, controller, _) {
        final models = controller.availableModels;
        final connected = controller.providerAvailable;

        return Card(
          child: ListTile(
            leading: const Icon(Icons.model_training_outlined),
            title: const Text('Model'),
            subtitle: Text(
              connected
                  ? 'Select the model to use'
                  : 'AI provider is not available',
            ),
            trailing: SizedBox(
              width: 220,
              child: connected
                  ? DropdownButton<String>(
                      isExpanded: true,
                      value: models.contains(controller.settings.model)
                          ? controller.settings.model
                          : null,
                      hint: const Text('Select Model'),
                      underline: const SizedBox(),
                      onChanged: models.isEmpty
                          ? null
                          : (value) {
                              if (value == null) return;

                              controller.setModel(value);
                            },
                      items: models.map((model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(
                            model,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                    )
                  : const Text(
                      'Offline',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}