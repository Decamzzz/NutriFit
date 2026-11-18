import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/asset_recipe_repository.dart';
import '../../domain/recipe.dart';
import '../../domain/recipe_category.dart';
import '../../domain/recipe_repository.dart';

part 'recipe_providers.g.dart';

/// Source of the recipes. Override in tests.
@riverpod
RecipeRepository recipeRepository(Ref ref) => AssetRecipeRepository();

/// The whole catalogue.
@riverpod
Future<List<Recipe>> recipes(Ref ref) =>
    ref.watch(recipeRepositoryProvider).loadAll();

/// A single recipe, or null when the id does not exist.
@riverpod
Future<Recipe?> recipeById(Ref ref, String id) async {
  final all = await ref.watch(recipesProvider.future);
  for (final recipe in all) {
    if (recipe.id == id) return recipe;
  }
  return null;
}

/// Selected category tab (null = all recipes).
@riverpod
class RecipeCategoryFilter extends _$RecipeCategoryFilter {
  @override
  RecipeCategory? build() => null;

  void select(RecipeCategory? category) => state = category;
}

/// The catalogue filtered by the selected tab.
@riverpod
Future<List<Recipe>> filteredRecipes(Ref ref) async {
  final all = await ref.watch(recipesProvider.future);
  final category = ref.watch(recipeCategoryFilterProvider);
  if (category == null) return all;
  return all.where((r) => r.category == category).toList();
}
