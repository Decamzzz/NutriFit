import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/utils/body_metrics.dart';

void main() {
  test('parseDecimal accepts dot and comma, rejects garbage', () {
    expect(parseDecimal('76.8'), 76.8);
    expect(parseDecimal(' 76,8 '), 76.8);
    expect(parseDecimal(''), isNull);
    expect(parseDecimal('abc'), isNull);
    expect(parseDecimal('1.2.3'), isNull);
    expect(parseDecimal('Infinity'), isNull);
  });

  test('weight and height ranges', () {
    expect(isValidWeightKg(70), isTrue);
    expect(isValidWeightKg(19.9), isFalse);
    expect(isValidWeightKg(501), isFalse);
    expect(isValidWeightKg(null), isFalse);
    expect(isValidHeightCm(175), isTrue);
    expect(isValidHeightCm(49), isFalse);
    expect(isValidHeightCm(261), isFalse);
  });

  test('roundToTenth and formatSignedKg', () {
    expect(roundToTenth(76.84), 76.8);
    expect(roundToTenth(76.85), 76.9);
    expect(formatSignedKg(-1.74), '-1.7');
    expect(formatSignedKg(0.4), '+0.4');
    expect(formatSignedKg(0), '0.0');
  });

  test('validateGoalWeight checks direction by goal', () {
    GoalWeightIssue? check(String goal, double? goalKg) =>
        validateGoalWeight(goal: goal, currentKg: 80, goalKg: goalKg);

    expect(check('lose', 70), isNull);
    expect(check('lose', 80), GoalWeightIssue.mustBeLower);
    expect(check('lose', 85), GoalWeightIssue.mustBeLower);
    expect(check('gain', 90), isNull);
    expect(check('gain', 75), GoalWeightIssue.mustBeHigher);
    expect(check('lose', null), GoalWeightIssue.invalid);
    expect(check('lose', 10), GoalWeightIssue.invalid);
  });
}
