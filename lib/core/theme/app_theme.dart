import 'package:flutter/material.dart';

import '../../features/settings/models/app_settings.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return _build(
      brightness: Brightness.light,
      seedColor: Colors.blue,
      scaffold: const Color(0xFFF5F5F5),
      card: Colors.white,
    );
  }

  static ThemeData dark() {
    return _build(
      brightness: Brightness.dark,
      seedColor: Colors.blue,
      scaffold: const Color(0xFF121212),
      card: const Color(0xFF1E1E1E),
    );
  }

  static ThemeData oled() {
    return _build(
      brightness: Brightness.dark,
      seedColor: Colors.blue,
      scaffold: Colors.black,
      card: const Color(0xFF090909),
    );
  }

  static ThemeData system(Brightness brightness) {
    return brightness == Brightness.dark
        ? dark()
        : light();
  }

  static ThemeData fromMode(
    AppThemeMode mode,
    Brightness systemBrightness,
  ) {
    switch (mode) {
      case AppThemeMode.system:
        return system(systemBrightness);

      case AppThemeMode.light:
        return light();

      case AppThemeMode.dark:
        return dark();

      case AppThemeMode.oled:
        return oled();

      // Reserved for future themes.
      case AppThemeMode.midnight:
      case AppThemeMode.dracula:
      case AppThemeMode.nord:
      case AppThemeMode.gruvbox:
      case AppThemeMode.oneDark:
      case AppThemeMode.custom:
        return dark();
    }
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color seedColor,
    required Color scaffold,
    required Color card,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,

      brightness: brightness,

      colorScheme: scheme,

      scaffoldBackgroundColor: scaffold,

      cardColor: card,

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
      ),

      dividerColor: scheme.outlineVariant,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      listTileTheme: const ListTileThemeData(
        dense: false,
      ),
    );
  }
}