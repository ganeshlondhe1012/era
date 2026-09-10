import 'package:flutter/material.dart';

import '../models/settings_category.dart';
import '../widgets/settings_content.dart';
import '../widgets/settings_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsCategory _selectedCategory = SettingsCategory.appearance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop / Tablet
          if (constraints.maxWidth >= 900) {
            return Row(
              children: [
                SettingsNavigation(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),

                const VerticalDivider(width: 1),

                Expanded(child: SettingsContent(category: _selectedCategory)),
              ],
            );
          }

          // Small screen / Mobile
          return Column(
            children: [
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  children: SettingsCategory.values.map((category) {
                    final selected = category == _selectedCategory;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category.title),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              Expanded(child: SettingsContent(category: _selectedCategory)),
            ],
          );
        },
      ),
    );
  }
}
