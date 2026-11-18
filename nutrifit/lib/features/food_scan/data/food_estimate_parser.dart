import 'dart:convert';

import '../../../core/errors/failure.dart';
import '../domain/food_estimate.dart';

/// Pure parser for the Gemini JSON answer. No network, fully testable.
abstract final class FoodEstimateParser {
  /// Parses a raw model answer into estimates.
  ///
  /// Tolerates markdown code fences and surrounding prose. Throws
  /// [Failure] when the payload is not usable.
  static List<FoodEstimate> parse(String raw) {
    final cleaned = _extractJsonArray(raw);
    if (cleaned == null) {
      throw const Failure.unknown(message: 'bad-json');
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(cleaned);
    } on FormatException {
      throw const Failure.unknown(message: 'bad-json');
    }
    final List<Object?> items;
    if (decoded is List<Object?>) {
      items = decoded;
    } else if (decoded is Map<String, Object?>) {
      items = [decoded];
    } else {
      throw const Failure.unknown(message: 'bad-json');
    }

    final estimates = <FoodEstimate>[];
    for (final item in items) {
      if (item is! Map) continue;
      final map = Map<String, Object?>.from(item);
      final name = (map['name'] ?? map['food_name'] ?? '').toString().trim();
      if (name.isEmpty) continue;
      estimates.add(
        FoodEstimate(
          name: name,
          grams: _toDouble(map['grams'] ?? map['grams_estimados'], 100),
          kcal: _toDouble(map['kcal'] ?? map['calories'], 0),
          protein: _toDouble(map['protein'], 0),
          carbs: _toDouble(map['carbs'] ?? map['carbohydrates'], 0),
          fat: _toDouble(map['fat'] ?? map['fats'], 0),
          confidence: _toDouble(map['confidence'], 0.5).clamp(0.0, 1.0),
        ),
      );
    }
    if (estimates.isEmpty) {
      throw const Failure.unknown(message: 'empty-result');
    }
    return estimates;
  }

  /// Returns the JSON array substring, or null when not found.
  static String? _extractJsonArray(String raw) {
    var text = raw.trim();
    // Remove markdown fences: ```json ... ```
    if (text.startsWith('```')) {
      final firstNewLine = text.indexOf('\n');
      final end = text.lastIndexOf('```');
      if (firstNewLine != -1 && end > firstNewLine) {
        text = text.substring(firstNewLine + 1, end).trim();
      } else {
        text = text.replaceAll('```', '').trim();
      }
    }
    final start = text.indexOf('[');
    final end = text.lastIndexOf(']');
    if (start != -1 && end > start) {
      return text.substring(start, end + 1);
    }
    // Allow a single object answer.
    final objStart = text.indexOf('{');
    final objEnd = text.lastIndexOf('}');
    if (objStart != -1 && objEnd > objStart) {
      return text.substring(objStart, objEnd + 1);
    }
    return null;
  }

  static double _toDouble(Object? raw, double fallback) {
    if (raw is num) return raw.toDouble();
    if (raw is String) {
      final cleaned = raw.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9.]'), '');
      final parsed = double.tryParse(cleaned);
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}
