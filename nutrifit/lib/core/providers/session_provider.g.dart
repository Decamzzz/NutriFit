// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current user id ('' when signed out).
///
/// The subscription is owned by this notifier and kept alive for the whole
/// app session, so the value is stable: the router guard, the realtime
/// syncs and the auth flows always agree on the same state.
///
/// The initial value comes from the restored session (synchronous), and the
/// stream keeps it up to date on every auth event.

@ProviderFor(SessionUserId)
final sessionUserIdProvider = SessionUserIdProvider._();

/// Current user id ('' when signed out).
///
/// The subscription is owned by this notifier and kept alive for the whole
/// app session, so the value is stable: the router guard, the realtime
/// syncs and the auth flows always agree on the same state.
///
/// The initial value comes from the restored session (synchronous), and the
/// stream keeps it up to date on every auth event.
final class SessionUserIdProvider
    extends $NotifierProvider<SessionUserId, String> {
  /// Current user id ('' when signed out).
  ///
  /// The subscription is owned by this notifier and kept alive for the whole
  /// app session, so the value is stable: the router guard, the realtime
  /// syncs and the auth flows always agree on the same state.
  ///
  /// The initial value comes from the restored session (synchronous), and the
  /// stream keeps it up to date on every auth event.
  SessionUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionUserIdHash();

  @$internal
  @override
  SessionUserId create() => SessionUserId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sessionUserIdHash() => r'626f0b2e78d39aa99797631aeee1f8561bb7d134';

/// Current user id ('' when signed out).
///
/// The subscription is owned by this notifier and kept alive for the whole
/// app session, so the value is stable: the router guard, the realtime
/// syncs and the auth flows always agree on the same state.
///
/// The initial value comes from the restored session (synchronous), and the
/// stream keeps it up to date on every auth event.

abstract class _$SessionUserId extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
