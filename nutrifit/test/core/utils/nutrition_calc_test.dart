import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/utils/nutrition_calc.dart';

void main() {
  test('BMI calculation', () {
    expect(calcBmi(weightKg: 76.8, heightCm: 175), closeTo(25.08, 0.05));
    expect(calcBmi(weightKg: 70, heightCm: 0), 0);
  });

  test('TDEE + calorie target by goal', () {
    final bmr = mifflinStJeor(
      weightKg: 76.8,
      heightCm: 175,
      age: 30,
      isMale: true,
    );
    final maintenance = tdee(
      bmr: bmr,
      activityFactor: ActivityFactors.moderate,
    );
    expect(
      calorieTarget(tdeeValue: maintenance, goal: 'lose'),
      (maintenance - 500).round(),
    );
    expect(
      calorieTarget(tdeeValue: maintenance, goal: 'maintain'),
      maintenance.round(),
    );
    expect(ActivityFactors.fromLevel('unknown'), ActivityFactors.moderate);
  });

  test('BMI categories follow the WHO adult thresholds', () {
    expect(bmiCategory(18.4), BmiCategory.underweight);
    expect(bmiCategory(18.5), BmiCategory.normal);
    expect(bmiCategory(24.9), BmiCategory.normal);
    expect(bmiCategory(25), BmiCategory.overweight);
    expect(bmiCategory(29.9), BmiCategory.overweight);
    expect(bmiCategory(30), BmiCategory.obese);
  });
}
