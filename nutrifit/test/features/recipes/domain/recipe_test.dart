import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/features/recipes/domain/recipe.dart';
import 'package:nutrifit/features/recipes/domain/recipe_category.dart';

List<Recipe> loadCatalogue() {
  final raw = File('assets/recipes/recipes.json').readAsStringSync();
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  return [
    for (final item in decoded['recipes'] as List<Object?>)
      Recipe.fromJson(item! as Map<String, dynamic>),
  ];
}

void main() {
  test('the bundled catalogue has at least 6 well-formed recipes', () {
    final recipes = loadCatalogue();
    expect(recipes.length, greaterThanOrEqualTo(6));
    expect(recipes.map((r) => r.id).toSet().length, recipes.length);

    for (final r in recipes) {
      expect(r.kcal, greaterThan(0), reason: r.id);
      expect(r.minutes, greaterThan(0), reason: r.id);
      expect(r.grams, greaterThan(0), reason: r.id);
      expect(r.ingredients, isNotEmpty, reason: r.id);
      expect(r.steps, isNotEmpty, reason: r.id);
      expect(r.name.es, isNotEmpty, reason: r.id);
      expect(r.name.en, isNotEmpty, reason: r.id);
      // calories must agree with the macros (4/4/9 kcal per gram, +-12%)
      final fromMacros = 4 * r.protein + 4 * r.carbs + 9 * r.fat;
      expect(
        (fromMacros - r.kcal).abs() / r.kcal,
        lessThan(0.12),
        reason: '${r.id}: kcal ${r.kcal} vs macros $fromMacros',
      );
    }
  });

  test('every category has at least one recipe', () {
    final recipes = loadCatalogue();
    for (final category in RecipeCategory.values) {
      expect(recipes.where((r) => r.category == category), isNotEmpty);
    }
  });

  test('LocalizedText picks the language and defaults to Spanish', () {
    final r = loadCatalogue().first;
    expect(r.name.of('en'), r.name.en);
    expect(r.name.of('en-US'), r.name.en);
    expect(r.name.of('es'), r.name.es);
    expect(r.name.of('fr'), r.name.es);
  });

  test('an unknown category is rejected', () {
    expect(
      () => Recipe.fromJson({
        'id': 'x',
        'category': 'brunch',
      }),
      throwsFormatException,
    );
  });
}
