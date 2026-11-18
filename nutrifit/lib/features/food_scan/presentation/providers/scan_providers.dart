import 'dart:async';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/gemini_food_scanner.dart';
import '../../domain/food_estimate.dart';
import '../../domain/food_scan_repository.dart';

part 'scan_providers.g.dart';

@riverpod
FoodScanRepository foodScanRepository(Ref ref) => GeminiFoodScanner();

/// Runs the AI analysis.
///
/// The state carries the estimates, so the UI can render the result as soon
/// as it arrives (no listener ordering issues).
@riverpod
class ScanController extends _$ScanController {
  @override
  FutureOr<List<FoodEstimate>> build() => const [];

  Future<void> analyze({
    required Uint8List imageBytes,
    required String mimeType,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(foodScanRepositoryProvider)
          .scanFood(imageBytes: imageBytes, mimeType: mimeType),
    );
  }

  void reset() => state = const AsyncData([]);
}
