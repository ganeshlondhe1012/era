enum SettingsCategory {
  appearance,
  ai,
  chat,
  memory,
  voice,
  privacy,
  advanced,
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

      case SettingsCategory.memory:
        return 'Memory';

      case SettingsCategory.voice:
        return 'Voice';

      case SettingsCategory.privacy:
        return 'Privacy';

      case SettingsCategory.advanced:
        return 'Advanced';
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

      case SettingsCategory.memory:
        return 'Long-term memory';

      case SettingsCategory.voice:
        return 'Speech features';

      case SettingsCategory.privacy:
        return 'Security and privacy';

      case SettingsCategory.advanced:
        return 'Developer options';
    }
  }
}