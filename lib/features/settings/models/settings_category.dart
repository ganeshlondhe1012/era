enum SettingsCategory {
  appearance,
  ai,
  chat
}

extension SettingsCategoryExtension on SettingsCategory {
  String get title {
    switch (this) {
      case SettingsCategory.appearance:
        return 'Appearance';

      case SettingsCategory.ai:
        return 'AI';

      case SettingsCategory.chat:
        return 'Chat';

     

      
    }
  }

  String get description {
    switch (this) {
      case SettingsCategory.appearance:
        return 'Themes, fonts and layout';

      case SettingsCategory.ai:
        return 'AI providers and models';

      case SettingsCategory.chat:
        return 'Chat experience';

     
    }
  }
}