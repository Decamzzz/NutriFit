import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/services/app_config.dart';
import 'package:nutrifit/features/food_scan/data/gemini_food_scanner.dart';

/// Manual probe against the real Gemini API (not part of the normal suite).
///
/// Run it with:
///   $env:GEMINI_PROBE='1'
///   flutter test --dart-define=GEMINI_API_KEY=KEY test/manual_gemini_probe_test.dart
///
/// Optional: `GEMINI_PROBE_IMAGE` to use another image.
void main() {
  final enabled = Platform.environment['GEMINI_PROBE'] == '1';
  final imagePath =
      Platform.environment['GEMINI_PROBE_IMAGE'] ?? 'src/screen2.png';

  test(
    'scans a real image with Gemini',
    () async {
      final file = File(imagePath);
      expect(file.existsSync(), isTrue, reason: 'missing $imagePath');
      final bytes = file.readAsBytesSync();

      final estimates = await GeminiFoodScanner().scanFood(
        imageBytes: bytes,
        mimeType: imagePath.endsWith('.png') ? 'image/png' : 'image/jpeg',
      );

      // ignore: avoid_print
      print('Estimates: ${estimates.length}');
      for (final e in estimates) {
        // ignore: avoid_print
        print(
          '  ${e.name} | ${e.grams}g | ${e.kcal}kcal | '
          'P:${e.protein} C:${e.carbs} G:${e.fat} | conf:${e.confidence}',
        );
      }
      expect(estimates, isNotEmpty);
    },
    skip: !enabled || !AppConfig.hasGemini
        ? 'Set GEMINI_PROBE=1 and pass --dart-define=GEMINI_API_KEY=...'
        : false,
  );
}
