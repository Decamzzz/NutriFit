import 'recipe.dart';

/// Recipe catalogue contract. Throws [Failure] on error.
abstract class RecipeRepository {
  Future<List<Recipe>> loadAll();
}
