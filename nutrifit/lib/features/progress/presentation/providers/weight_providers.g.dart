// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backend access to the weight logs. Override in tests.

@ProviderFor(weightRepository)
final weightRepositoryProvider = WeightRepositoryProvider._();

/// Backend access to the weight logs. Override in tests.

final class WeightRepositoryProvider
    extends
        $FunctionalProvider<
          WeightRepository,
          WeightRepository,
          WeightRepository
        >
    with $Provider<WeightRepository> {
  /// Backend access to the weight logs. Override in tests.
  WeightRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeightRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeightRepository create(Ref ref) {
    return weightRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeightRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeightRepository>(value),
    );
  }
}

String _$weightRepositoryHash() => r'53d5d4d95344dba297cd70902af70f82bcd6e21e';

/// All the weight logs of the current user (oldest first).

@ProviderFor(weightLogs)
final weightLogsProvider = WeightLogsProvider._();

/// All the weight logs of the current user (oldest first).

final class WeightLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeightLog>>,
          List<WeightLog>,
          FutureOr<List<WeightLog>>
        >
    with $FutureModifier<List<WeightLog>>, $FutureProvider<List<WeightLog>> {
  /// All the weight logs of the current user (oldest first).
  WeightLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightLogsHash();

  @$internal
  @override
  $FutureProviderElement<List<WeightLog>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WeightLog>> create(Ref ref) {
    return weightLogs(ref);
  }
}

String _$weightLogsHash() => r'91d8e928a7bf53c27d05d5752a40982cbbbc5691';

/// Logs + height + goal weight, ready for the progress screen.

@ProviderFor(weightSummary)
final weightSummaryProvider = WeightSummaryProvider._();

/// Logs + height + goal weight, ready for the progress screen.

final class WeightSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeightSummary>,
          WeightSummary,
          FutureOr<WeightSummary>
        >
    with $FutureModifier<WeightSummary>, $FutureProvider<WeightSummary> {
  /// Logs + height + goal weight, ready for the progress screen.
  WeightSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightSummaryHash();

  @$internal
  @override
  $FutureProviderElement<WeightSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeightSummary> create(Ref ref) {
    return weightSummary(ref);
  }
}

String _$weightSummaryHash() => r'6f702d37f8ebde35073d487f3f714e04f0de991c';

/// Keeps the logs in sync with Supabase Realtime (this or another device).

@ProviderFor(weightRealtimeSync)
final weightRealtimeSyncProvider = WeightRealtimeSyncProvider._();

/// Keeps the logs in sync with Supabase Realtime (this or another device).

final class WeightRealtimeSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  /// Keeps the logs in sync with Supabase Realtime (this or another device).
  WeightRealtimeSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightRealtimeSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightRealtimeSyncHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return weightRealtimeSync(ref);
  }
}

String _$weightRealtimeSyncHash() =>
    r'37a479c159fdf75dc0c0ccb7cd0d3e5f88dc20cc';

/// Add / replace / remove controller. UI watches the AsyncValue.

@ProviderFor(WeightEditor)
final weightEditorProvider = WeightEditorProvider._();

/// Add / replace / remove controller. UI watches the AsyncValue.
final class WeightEditorProvider
    extends $AsyncNotifierProvider<WeightEditor, void> {
  /// Add / replace / remove controller. UI watches the AsyncValue.
  WeightEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightEditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightEditorHash();

  @$internal
  @override
  WeightEditor create() => WeightEditor();
}

String _$weightEditorHash() => r'c971d86540eddf3744c622187f2f1e7bfaa69375';

/// Add / replace / remove controller. UI watches the AsyncValue.

abstract class _$WeightEditor extends $AsyncNotifier<void> {
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
