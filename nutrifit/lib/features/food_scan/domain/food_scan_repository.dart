import 'dart:typed_data';

import 'food_estimate.dart';

/// Contract for AI food estimation. Implementations throw [Failure].
abstract class FoodScanRepository {
  /// Estimates the foods visible in the given image.
  Future<List<FoodEstimate>> scanFood({
    required Uint8List imageBytes,
    required String mimeType,
  });
}
