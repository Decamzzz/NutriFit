import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/l10n/app_strings.dart';
import 'package:nutrifit/core/utils/nutrition_calc.dart';

void main() {
  test('ES is default, EN resolves by code', () {
    expect(AppStrings.ofCode('es').startPlan, 'Comienza tu plan');
    expect(AppStrings.ofCode('en').startPlan, 'Start your plan');
    expect(AppStrings.ofCode('es-MX').home, 'Inicio');
  });

  test('weight, BMI and recipe strings exist in both languages', () {
    const es = EsStrings();
    const en = EnStrings();
    expect(es.kgValue(76.84), '76.8 kg');
    expect(en.kgValue(76.84), '76.8 kg');
    expect(es.bmiValue('24.1'), 'Tu IMC: 24.1');
    expect(en.bmiValue('24.1'), 'Your BMI: 24.1');
    expect(es.weightChange7d('-1.7'), '-1.7 kg en 7 días');
    expect(en.minutesValue(15), '15 min');
    for (final c in BmiCategory.values) {
      expect(es.bmiCategoryLabel(c), isNot(en.bmiCategoryLabel(c)));
    }
    expect(es.healthyRecipes, 'Recetas Saludables');
    expect(en.healthyRecipes, 'Healthy Recipes');
  });
}
