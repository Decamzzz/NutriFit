import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/errors/failure.dart';
import 'package:nutrifit/features/food_scan/domain/food_estimate.dart';
import 'package:nutrifit/features/food_scan/domain/food_scan_repository.dart';
import 'package:nutrifit/features/food_scan/presentation/providers/scan_providers.dart';

/// Fake repository: returns a fixed result or throws.
class _FakeScanner implements FoodScanRepository {
  _FakeScanner(this.result, {this.error});

  final List<FoodEstimate> result;
  final Object? error;

  @override
  Future<List<FoodEstimate>> scanFood({
    required Uint8List imageBytes,
    required String mimeType,
  }) async {
    if (error != null) throw error!;
    return result;
  }
}

void main() {
  const estimate = FoodEstimate(
    name: 'Huevo cocido',
    grams: 100,
    kcal: 155,
    protein: 13,
    carbs: 1,
    fat: 11,
    confidence: 0.9,
  );

  test('ScanController exposes the estimates on success', () async {
    final container = ProviderContainer(
      overrides: [
        foodScanRepositoryProvider.overrideWithValue(
          _FakeScanner(const [estimate]),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(scanControllerProvider.notifier)
        .analyze(
          imageBytes: Uint8List.fromList([1, 2, 3]),
          mimeType: 'image/jpeg',
        );

    final state = container.read(scanControllerProvider);
    expect(state.hasValue, isTrue);
    expect(state.hasError, isFalse);
    expect(state.requireValue.single.name, 'Huevo cocido');
    expect(state.requireValue.single.kcal, 155);
  });

  test('ScanController keeps the error state and no estimates', () async {
    final container = ProviderContainer(
      overrides: [
        foodScanRepositoryProvider.overrideWithValue(
          _FakeScanner(const [], error: const Failure.network()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(scanControllerProvider.notifier)
        .analyze(imageBytes: Uint8List.fromList([1]), mimeType: 'image/jpeg');

    final state = container.read(scanControllerProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<Failure>());
    expect(state.requireValue, isEmpty);
  });

  test('ScanController reports loading while running', () async {
    final container = ProviderContainer(
      overrides: [
        foodScanRepositoryProvider.overrideWithValue(
          _FakeScanner(const [estimate]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(scanControllerProvider.notifier);
    final future = notifier.analyze(
      imageBytes: Uint8List.fromList([1]),
      mimeType: 'image/jpeg',
    );
    expect(container.read(scanControllerProvider).isLoading, isTrue);
    await future;
    expect(container.read(scanControllerProvider).isLoading, isFalse);
  });

  test('regression: the estimates are already available when the state '
      'changes (the UI must be able to render them right away)', () async {
    final container = ProviderContainer(
      overrides: [
        foodScanRepositoryProvider.overrideWithValue(
          _FakeScanner(const [estimate]),
        ),
      ],
    );
    addTearDown(container.dispose);

    List<FoodEstimate>? seenOnNotification;
    container.listen(
      scanControllerProvider,
      (previous, next) {
        if (next.hasValue) seenOnNotification = next.requireValue;
      },
      fireImmediately: true,
    );

    await container
        .read(scanControllerProvider.notifier)
        .analyze(imageBytes: Uint8List.fromList([1]), mimeType: 'image/jpeg');

    expect(seenOnNotification, isNotNull);
    expect(seenOnNotification!.single.name, 'Huevo cocido');
  });
}
