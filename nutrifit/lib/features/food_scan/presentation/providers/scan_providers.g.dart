// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodScanRepository)
final foodScanRepositoryProvider = FoodScanRepositoryProvider._();

final class FoodScanRepositoryProvider
    extends
        $FunctionalProvider<
          FoodScanRepository,
          FoodScanRepository,
          FoodScanRepository
        >
    with $Provider<FoodScanRepository> {
  FoodScanRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodScanRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodScanRepositoryHash();

  @$internal
  @override
  $ProviderElement<FoodScanRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FoodScanRepository create(Ref ref) {
    return foodScanRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodScanRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodScanRepository>(value),
    );
  }
}

String _$foodScanRepositoryHash() =>
    r'681385f533ff17a578da55e4877c4e11fab7d887';

/// Runs the AI analysis.
///
/// The state carries the estimates, so the UI can render the result as soon
/// as it arrives (no listener ordering issues).

@ProviderFor(ScanController)
final scanControllerProvider = ScanControllerProvider._();

/// Runs the AI analysis.
///
/// The state carries the estimates, so the UI can render the result as soon
/// as it arrives (no listener ordering issues).
final class ScanControllerProvider
    extends $AsyncNotifierProvider<ScanController, List<FoodEstimate>> {
  /// Runs the AI analysis.
  ///
  /// The state carries the estimates, so the UI can render the result as soon
  /// as it arrives (no listener ordering issues).
  ScanControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanControllerHash();

  @$internal
  @override
  ScanController create() => ScanController();
}

String _$scanControllerHash() => r'd1b91d376a11ff93f1efac4bb0ff5fb4c5701515';

/// Runs the AI analysis.
///
/// The state carries the estimates, so the UI can render the result as soon
/// as it arrives (no listener ordering issues).

abstract class _$ScanController extends $AsyncNotifier<List<FoodEstimate>> {
  FutureOr<List<FoodEstimate>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FoodEstimate>>, List<FoodEstimate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FoodEstimate>>, List<FoodEstimate>>,
              AsyncValue<List<FoodEstimate>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
