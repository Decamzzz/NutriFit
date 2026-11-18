/// Pure helpers for body measurements: parsing, validation and formatting.
/// No Flutter dependencies so they are unit-testable.
library;

/// Accepted ranges. Keep in sync with the CHECK constraints in
/// `supabase/migrations/20261117120000_fase3_body_weight.sql`.
abstract final class BodyLimits {
  static const double minWeightKg = 20;
  static const double maxWeightKg = 500;
  static const double minHeightCm = 50;
  static const double maxHeightCm = 260;
}

/// Parses a decimal typed by the user. Accepts both `76.8` and `76,8`.
double? parseDecimal(String raw) {
  final text = raw.trim().replaceAll(',', '.');
  if (text.isEmpty) return null;
  final value = double.tryParse(text);
  if (value == null || value.isNaN || value.isInfinite) return null;
  return value;
}

bool isValidWeightKg(double? kg) =>
    kg != null && kg >= BodyLimits.minWeightKg && kg <= BodyLimits.maxWeightKg;

bool isValidHeightCm(double? cm) =>
    cm != null && cm >= BodyLimits.minHeightCm && cm <= BodyLimits.maxHeightCm;

/// Rounds to one decimal (the precision shown everywhere in the app).
double roundToTenth(double value) => (value * 10).round() / 10;

/// `+0.4` / `-1.7` / `0.0`, for weight deltas.
String formatSignedKg(double value) {
  final rounded = roundToTenth(value);
  final text = rounded.toStringAsFixed(1);
  return rounded > 0 ? '+$text' : text;
}

enum GoalWeightIssue { invalid, mustBeLower, mustBeHigher }

/// Checks a goal weight against the chosen goal ('lose' | 'maintain' | 'gain').
/// Returns null when it is acceptable.
GoalWeightIssue? validateGoalWeight({
  required String goal,
  required double? currentKg,
  required double? goalKg,
}) {
  if (goalKg == null || !isValidWeightKg(goalKg)) {
    return GoalWeightIssue.invalid;
  }
  if (currentKg == null) return null;
  if (goal == 'lose' && goalKg >= currentKg) return GoalWeightIssue.mustBeLower;
  if (goal == 'gain' && goalKg <= currentKg) {
    return GoalWeightIssue.mustBeHigher;
  }
  return null;
}
