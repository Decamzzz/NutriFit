import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/l10n/app_strings.dart';

part 'app_settings.g.dart';

/// Persisted ThemeMode. UI reads themeModeProvider; widgets never touch prefs.
@riverpod
class ThemeModeSetting extends _$ThemeModeSetting {
  @override
  ThemeMode build() => ThemeMode.system;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(AppConstants.prefsThemeMode);
    state = switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsThemeMode, mode.name);
  }
}

/// Persisted locale code ('es' default). Widgets read stringsProvider.
@riverpod
class LocaleSetting extends _$LocaleSetting {
  @override
  Locale build() => const Locale('es');

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw =
        prefs.getString(AppConstants.prefsLocale) ??
        AppConstants.supportedLocales.first;
    state = Locale(raw);
  }

  Future<void> set(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsLocale, locale.languageCode);
  }
}

/// Single i18n entry point for widgets (satisfies "no hardcoded strings").
@riverpod
AppStrings strings(Ref ref) {
  final locale = ref.watch(localeSettingProvider);
  return AppStrings.ofCode(locale.languageCode);
}
