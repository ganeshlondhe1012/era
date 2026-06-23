import 'package:flutter/material.dart';

import '../models/settings_category.dart';

class SettingsNavigation extends StatelessWidget {
  const SettingsNavigation({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final SettingsCategory selectedCategory;
  final ValueChanged<SettingsCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Configure Era',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: SettingsCategory.values.map((category) {
                final isSelected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    selected: isSelected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Icon(_icon(category)),
                    title: Text(category.title),
                    subtitle: Text(
                      category.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => onCategorySelected(category),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _icon(SettingsCategory category) {
    switch (category) {
      case SettingsCategory.appearance:
        return Icons.palette_outlined;

      case SettingsCategory.ai:
        return Icons.smart_toy_outlined;

      case SettingsCategory.chat:
        return Icons.chat_bubble_outline;

      case SettingsCategory.memory:
        return Icons.memory_outlined;

      case SettingsCategory.voice:
        return Icons.mic_none_outlined;

      case SettingsCategory.privacy:
        return Icons.security_outlined;

      case SettingsCategory.advanced:
        return Icons.settings_outlined;
    }
  }
}