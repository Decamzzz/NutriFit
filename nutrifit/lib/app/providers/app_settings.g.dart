// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted ThemeMode. UI reads themeModeProvider; widgets never touch prefs.

@ProviderFor(ThemeModeSetting)
final themeModeSettingProvider = ThemeModeSettingProvider._();

/// Persisted ThemeMode. UI reads themeModeProvider; widgets never touch prefs.
final class ThemeModeSettingProvider
    extends $NotifierProvider<ThemeModeSetting, ThemeMode> {
  /// Persisted ThemeMode. UI reads themeModeProvider; widgets never touch prefs.
  ThemeModeSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeSettingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeSettingHash();

  @$internal
  @override
  ThemeModeSetting create() => ThemeModeSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeSettingHash() => r'bf8638a580dfc10074e25b2ed2862b451a5fb34d';

/// Persisted ThemeMode. UI reads themeModeProvider; widgets never touch prefs.

abstract class _$ThemeModeSetting extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Persisted locale code ('es' default). Widgets read stringsProvider.

@ProviderFor(LocaleSetting)
final localeSettingProvider = LocaleSettingProvider._();

/// Persisted locale code ('es' default). Widgets read stringsProvider.
final class LocaleSettingProvider
    extends $NotifierProvider<LocaleSetting, Locale> {
  /// Persisted locale code ('es' default). Widgets read stringsProvider.
  LocaleSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeSettingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeSettingHash();

  @$internal
  @override
  LocaleSetting create() => LocaleSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$localeSettingHash() => r'533d1fb73c8e639456dd19cbcab05b2a4b901f15';

/// Persisted locale code ('es' default). Widgets read stringsProvider.

abstract class _$LocaleSetting extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Single i18n entry point for widgets (satisfies "no hardcoded strings").

@ProviderFor(strings)
final stringsProvider = StringsProvider._();

/// Single i18n entry point for widgets (satisfies "no hardcoded strings").

final class StringsProvider
    extends $FunctionalProvider<AppStrings, AppStrings, AppStrings>
    with $Provider<AppStrings> {
  /// Single i18n entry point for widgets (satisfies "no hardcoded strings").
  StringsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stringsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stringsHash();

  @$internal
  @override
  $ProviderElement<AppStrings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppStrings create(Ref ref) {
    return strings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppStrings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppStrings>(value),
    );
  }
}

String _$stringsHash() => r'00d8333a260cebf75509ca2f22c6eef35f692a15';
