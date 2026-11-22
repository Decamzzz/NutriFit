import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/user_settings_provider.dart';
import '../features/diary/presentation/providers/diary_providers.dart';
import '../features/progress/presentation/providers/weight_providers.dart';
import 'providers/app_settings.dart';
import 'router.dart';
import 'theme/app_theme.dart';

/// Root widget. Watches theme + locale; loads persisted prefs on start.
class NutriFitApp extends ConsumerStatefulWidget {
  const NutriFitApp({super.key});

  @override
  ConsumerState<NutriFitApp> createState() => _NutriFitAppState();
}

class _NutriFitAppState extends ConsumerState<NutriFitApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(themeModeSettingProvider.notifier).load();
      ref.read(localeSettingProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Keep the UI in sync with Supabase Realtime (diary, weight + profile).
    ref.watch(diaryRealtimeSyncProvider);
    ref.watch(weightRealtimeSyncProvider);
    ref.watch(userSettingsRealtimeSyncProvider);
    final themeMode = ref.watch(themeModeSettingProvider);
    final locale = ref.watch(localeSettingProvider);
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'NutriFit',
      // Hide the "DEBUG" ribbon that Flutter draws over every screen.
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [Locale('es'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
