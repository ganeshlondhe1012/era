enum AppThemeMode {
  system,
  light,
  dark,
  oled,
  midnight,
  dracula,
  nord,
  gruvbox,
  oneDark,
  custom,
}

class AppSettings {
  const AppSettings({
    required this.themeMode,
  });

  final AppThemeMode themeMode;

  AppSettings copyWith({
    AppThemeMode? themeMode,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
    };
  }

  factory AppSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final value = json['themeMode'];

    final mode = AppThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeMode.system,
    );

    return AppSettings(
      themeMode: mode,
    );
  }

  static const defaults = AppSettings(
    themeMode: AppThemeMode.system,
  );
}