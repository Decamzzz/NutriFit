import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/features/recipes/domain/localized_text.dart';
import 'package:nutrifit/features/recipes/domain/recipe.dart';
import 'package:nutrifit/features/recipes/domain/recipe_category.dart';
import 'package:nutrifit/features/recipes/domain/recipe_repository.dart';
import 'package:nutrifit/features/recipes/presentation/pages/recipes_page.dart';
import 'package:nutrifit/features/recipes/presentation/providers/recipe_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Recipe _recipe(String id, RecipeCategory category, String name, int kcal) =>
    Recipe(
      id: id,
      category: category,
      emoji: '🥗',
      image: '',
      minutes: 10,
      grams: 200,
      kcal: kcal,
      protein: 10,
      carbs: 20,
      fat: 5,
      name: LocalizedText(es: name, en: name),
      description: const LocalizedText(es: 'd', en: 'd'),
      ingredients: const [LocalizedText(es: 'i', en: 'i')],
      steps: const [LocalizedText(es: 's', en: 's')],
    );

class _FakeRecipeRepository implements RecipeRepository {
  @override
  Future<List<Recipe>> loadAll() async => [
    _recipe('a', RecipeCategory.breakfast, 'Avena', 300),
    _recipe('b', RecipeCategory.dinner, 'Sopa', 350),
  ];
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('lists recipes with kcal and filters by category', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          recipeRepositoryProvider.overrideWithValue(_FakeRecipeRepository()),
        ],
        child: const MaterialApp(home: RecipesPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Avena'), findsOneWidget);
    expect(find.text('Sopa'), findsOneWidget);
    expect(find.text('300 kcal'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Cena'));
    await tester.pumpAndSettle();

    expect(find.text('Avena'), findsNothing);
    expect(find.text('Sopa'), findsOneWidget);
  });
}
