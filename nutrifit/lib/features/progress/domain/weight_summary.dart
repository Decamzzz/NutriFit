import '../../../core/utils/date_utils.dart';
import '../../../core/utils/nutrition_calc.dart';
import 'weight_log.dart';

/// Everything the progress screen shows, derived from the weight logs plus
/// the height / goal weight of the profile. Pure Dart: unit-testable.
class WeightSummary {
  const WeightSummary._({
    required this.logs,
    this.heightCm,
    this.goalWeightKg,
  });

  /// [logs] may come in any order; they are sorted oldest first.
  factory WeightSummary.from({
    required List<WeightLog> logs,
    double? heightCm,
    double? goalWeightKg,
  }) {
    final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    return WeightSummary._(
      logs: List.unmodifiable(sorted),
      heightCm: heightCm,
      goalWeightKg: goalWeightKg,
    );
  }

  /// Oldest first.
  final List<WeightLog> logs;
  final double? heightCm;
  final double? goalWeightKg;

  bool get isEmpty => logs.isEmpty;

  double? get currentKg => logs.isEmpty ? null : logs.last.weightKg;

  double? get startKg => logs.isEmpty ? null : logs.first.weightKg;

  /// Current minus starting weight (null with fewer than two logs).
  double? get changeSinceStart {
    if (logs.length < 2) return null;
    return logs.last.weightKg - logs.first.weightKg;
  }

  /// Change across the logs of the last 7 days (the earliest log inside the
  /// window is the baseline). Null when there is nothing to compare.
  double? get weeklyChange {
    if (logs.length < 2) return null;
    final last = logs.last;
    final lastDay = parseYmd(last.date);
    final cutoff = ymd(DateTime(lastDay.year, lastDay.month, lastDay.day - 7));
    final baseline = logs.firstWhere((l) => l.date.compareTo(cutoff) >= 0);
    if (baseline.date == last.date) return null;
    return last.weightKg - baseline.weightKg;
  }

  /// Body-mass index with the current weight (null without height or logs).
  double? get bmi {
    final h = heightCm;
    final w = currentKg;
    if (h == null || w == null) return null;
    return calcBmi(weightKg: w, heightCm: h);
  }

  BmiCategory? get bmiCategoryValue {
    final value = bmi;
    return value == null ? null : bmiCategory(value);
  }

  /// 0..1 progress from the starting weight toward the goal weight. Works
  /// for losing and gaining. Null when there is no goal or when the goal
  /// equals the starting weight (maintenance).
  double? get goalProgress {
    final start = startKg;
    final goal = goalWeightKg;
    final current = currentKg;
    if (start == null || goal == null || current == null) return null;
    final total = start - goal;
    if (total.abs() < 0.05) return null;
    return ((start - current) / total).clamp(0.0, 1.0).toDouble();
  }

  /// Signed distance still to go: goal minus current (positive = gain).
  double? get remainingToGoal {
    final goal = goalWeightKg;
    final current = currentKg;
    if (goal == null || current == null) return null;
    return goal - current;
  }

  bool get goalReached {
    final start = startKg;
    final goal = goalWeightKg;
    final current = currentKg;
    if (start == null || goal == null || current == null) return false;
    if (goal < start) return current <= goal;
    if (goal > start) return current >= goal;
    return false;
  }
}
