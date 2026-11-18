import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/utils/nutrition_calc.dart';
import 'package:nutrifit/features/progress/domain/weight_chart_data.dart';
import 'package:nutrifit/features/progress/domain/weight_log.dart';
import 'package:nutrifit/features/progress/domain/weight_summary.dart';

WeightLog log(String date, double kg) => WeightLog(date: date, weightKg: kg);

void main() {
  group('WeightSummary', () {
    test('empty summary has no derived values', () {
      final s = WeightSummary.from(logs: const [], heightCm: 175);
      expect(s.isEmpty, isTrue);
      expect(s.currentKg, isNull);
      expect(s.bmi, isNull);
      expect(s.weeklyChange, isNull);
      expect(s.goalProgress, isNull);
      expect(s.goalReached, isFalse);
    });

    test('sorts logs and exposes start/current/total change', () {
      final s = WeightSummary.from(
        logs: [log('2026-11-10', 78), log('2026-11-01', 80), log('2026-11-05', 79)],
      );
      expect(s.logs.map((l) => l.date).first, '2026-11-01');
      expect(s.startKg, 80);
      expect(s.currentKg, 78);
      expect(s.changeSinceStart, -2);
    });

    test('weeklyChange uses the earliest log of the last 7 days', () {
      final s = WeightSummary.from(
        logs: [
          log('2026-10-01', 85), // outside the window
          log('2026-11-10', 80),
          log('2026-11-14', 79),
          log('2026-11-17', 78.3),
        ],
      );
      // window starts 2026-11-10 -> baseline 80
      expect(s.weeklyChange, closeTo(-1.7, 1e-9));
    });

    test('weeklyChange is null when nothing else is inside the window', () {
      final s = WeightSummary.from(
        logs: [log('2026-10-01', 85), log('2026-11-17', 80)],
      );
      expect(s.weeklyChange, isNull);
    });

    test('bmi and category use the latest weight', () {
      final s = WeightSummary.from(
        logs: [log('2026-11-01', 90), log('2026-11-17', 76.8)],
        heightCm: 175,
      );
      expect(s.bmi, closeTo(25.08, 0.05));
      expect(s.bmiCategoryValue, BmiCategory.overweight);
      expect(WeightSummary.from(logs: [log('2026-11-01', 80)]).bmi, isNull);
    });

    test('goal progress when losing weight', () {
      final s = WeightSummary.from(
        logs: [log('2026-11-01', 90), log('2026-11-17', 85)],
        goalWeightKg: 80,
      );
      expect(s.goalProgress, closeTo(0.5, 1e-9));
      expect(s.remainingToGoal, -5);
      expect(s.goalReached, isFalse);
    });

    test('goal progress when gaining weight', () {
      final s = WeightSummary.from(
        logs: [log('2026-11-01', 60), log('2026-11-17', 63)],
        goalWeightKg: 66,
      );
      expect(s.goalProgress, closeTo(0.5, 1e-9));
      expect(s.remainingToGoal, 3);
    });

    test('progress is clamped and goal reached is detected', () {
      final lose = WeightSummary.from(
        logs: [log('2026-11-01', 90), log('2026-11-17', 79)],
        goalWeightKg: 80,
      );
      expect(lose.goalProgress, 1);
      expect(lose.goalReached, isTrue);

      final wrongWay = WeightSummary.from(
        logs: [log('2026-11-01', 90), log('2026-11-17', 95)],
        goalWeightKg: 80,
      );
      expect(wrongWay.goalProgress, 0);
      expect(wrongWay.goalReached, isFalse);
    });

    test('maintenance (goal == start) has no progress bar', () {
      final s = WeightSummary.from(
        logs: [log('2026-11-01', 70), log('2026-11-17', 71)],
        goalWeightKg: 70,
      );
      expect(s.goalProgress, isNull);
      expect(s.goalReached, isFalse);
    });
  });

  group('WeightChartData', () {
    test('x is days since the first log and bounds contain the goal', () {
      final data = WeightChartData.from(
        logs: [log('2026-11-01', 80), log('2026-11-05', 79), log('2026-11-11', 77.5)],
        goalKg: 70,
      );
      expect(data.points.map((p) => p.x), [0, 4, 10]);
      expect(data.lastX, 10);
      expect(data.maxX, greaterThan(data.lastX));
      expect(data.minY, lessThanOrEqualTo(70));
      expect(data.maxY, greaterThanOrEqualTo(80));
      expect(data.dateAt(10), DateTime(2026, 11, 11));
      // whole-number ticks
      expect(data.minY % data.yInterval, 0);
      expect(data.maxY % data.yInterval, 0);
    });

    test('a single log still produces a drawable range', () {
      final data = WeightChartData.from(logs: [log('2026-11-01', 76.8)]);
      expect(data.lastX, 0);
      expect(data.maxX, greaterThan(data.minX));
      expect(data.maxY, greaterThan(data.minY));
      expect(data.minY, lessThan(76.8));
      expect(data.maxY, greaterThan(76.8));
    });
  });
}
