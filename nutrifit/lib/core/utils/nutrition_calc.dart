/// Pure nutrition math. No Flutter dependencies so it is unit-testable.
library;

/// Body-mass index.
double calcBmi({required double weightKg, required double heightCm}) {
  final hM = heightCm / 100;
  if (hM <= 0) return 0;
  return weightKg / (hM * hM);
}

/// Mifflin-St Jeor basal metabolic rate.
double mifflinStJeor({
  required double weightKg,
  required double heightCm,
  required int age,
  required bool isMale,
}) {
  final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
  return isMale ? base + 5 : base - 161;
}

/// Total daily energy expenditure from activity factor.
double tdee({required double bmr, required double activityFactor}) =>
    bmr * activityFactor;

/// Activity factors used in profile setup.
abstract final class ActivityFactors {
  static const double sedentary = 1.2;
  static const double light = 1.375;
  static const double moderate = 1.55;
  static const double active = 1.725;

  static double fromLevel(String level) => switch (level) {
    'sedentary' => sedentary,
    'light' => light,
    'moderate' => moderate,
    'active' => active,
    _ => moderate,
  };
}

/// Suggested calorie target from goal adjustment (-500 cut, +300 gain).
int calorieTarget({required double tdeeValue, required String goal}) {
  final adjust = switch (goal) {
    'lose' => -500,
    'gain' => 300,
    _ => 0,
  };
  return (tdeeValue + adjust).round();
}

/// WHO adult BMI categories.
enum BmiCategory { underweight, normal, overweight, obese }

BmiCategory bmiCategory(double bmi) {
  if (bmi < 18.5) return BmiCategory.underweight;
  if (bmi < 25) return BmiCategory.normal;
  if (bmi < 30) return BmiCategory.overweight;
  return BmiCategory.obese;
}
