import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ai/providers/ollam_provider.dart';
import '../core/theme/app_theme.dart';

import '../features/chat/controllers/chat_controller.dart';
import '../features/chat/screens/home_screen.dart';
import '../features/chat/services/ollama_service.dart';

import '../features/settings/controllers/settings_controller.dart';
import '../features/settings/models/app_settings.dart';

import '../features/ai/controllers/ai_settings_controller.dart';

class EraApp extends StatelessWidget {
  const EraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsController>(
          create: (_) {
            final controller = SettingsController();
            controller.initialize();
            return controller;
          },
        ),

        ChangeNotifierProvider<AISettingsController>(
          create: (_) {
            final controller = AISettingsController();
            controller.initialize();
            return controller;
          },
        ),
        
        ChangeNotifierProvider<ChatController>(
          create: (_) {
            final ollamaService = OllamaService();

            final provider = OllamaProvider(
              service: ollamaService,
            );

            return ChatController(
              provider: provider,
            );
          },
        ),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Era',

            theme: AppTheme.light(),

            darkTheme: AppTheme.dark(),

            themeMode: _toFlutterThemeMode(
              settings.themeMode,
            ),

            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  ThemeMode _toFlutterThemeMode(
    AppThemeMode mode,
  ) {
    switch (mode) {
      case AppThemeMode.system:
        return ThemeMode.system;

      case AppThemeMode.light:
        return ThemeMode.light;

      default:
        return ThemeMode.dark;
    }
  }
}