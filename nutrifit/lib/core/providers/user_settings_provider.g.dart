// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backend access to the user profile. Override in tests.

@ProviderFor(userSettingsPort)
final userSettingsPortProvider = UserSettingsPortProvider._();

/// Backend access to the user profile. Override in tests.

final class UserSettingsPortProvider
    extends
        $FunctionalProvider<
          UserSettingsPort,
          UserSettingsPort,
          UserSettingsPort
        >
    with $Provider<UserSettingsPort> {
  /// Backend access to the user profile. Override in tests.
  UserSettingsPortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsPortProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsPortHash();

  @$internal
  @override
  $ProviderElement<UserSettingsPort> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserSettingsPort create(Ref ref) {
    return userSettingsPort(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserSettingsPort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserSettingsPort>(value),
    );
  }
}

String _$userSettingsPortHash() => r'8a495961c3cbc0510351ef6cab3eb7bc036747db';

/// Current user settings (null when signed out).

@ProviderFor(userSettings)
final userSettingsProvider = UserSettingsProvider._();

/// Current user settings (null when signed out).

final class UserSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserSettings?>,
          UserSettings?,
          FutureOr<UserSettings?>
        >
    with $FutureModifier<UserSettings?>, $FutureProvider<UserSettings?> {
  /// Current user settings (null when signed out).
  UserSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsHash();

  @$internal
  @override
  $FutureProviderElement<UserSettings?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserSettings?> create(Ref ref) {
    return userSettings(ref);
  }
}

String _$userSettingsHash() => r'567688299e22a795fd3223ba3cab1e92ef76b4a1';

/// Keeps the settings in sync with Supabase Realtime so any change (this
/// device or another) is reflected without re-login.

@ProviderFor(userSettingsRealtimeSync)
final userSettingsRealtimeSyncProvider = UserSettingsRealtimeSyncProvider._();

/// Keeps the settings in sync with Supabase Realtime so any change (this
/// device or another) is reflected without re-login.

final class UserSettingsRealtimeSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  /// Keeps the settings in sync with Supabase Realtime so any change (this
  /// device or another) is reflected without re-login.
  UserSettingsRealtimeSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsRealtimeSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsRealtimeSyncHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return userSettingsRealtimeSync(ref);
  }
}

String _$userSettingsRealtimeSyncHash() =>
    r'99551ba8fb2d6285b416f88892988238bd75d14d';

/// Goal editor. Invalidates the cached settings on success.

@ProviderFor(UserSettingsEditor)
final userSettingsEditorProvider = UserSettingsEditorProvider._();

/// Goal editor. Invalidates the cached settings on success.
final class UserSettingsEditorProvider
    extends $AsyncNotifierProvider<UserSettingsEditor, void> {
  /// Goal editor. Invalidates the cached settings on success.
  UserSettingsEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsEditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsEditorHash();

  @$internal
  @override
  UserSettingsEditor create() => UserSettingsEditor();
}

String _$userSettingsEditorHash() =>
    r'73408b7914b7668a87d3a4ae533071c70c3715e5';

/// Goal editor. Invalidates the cached settings on success.

abstract class _$UserSettingsEditor extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
