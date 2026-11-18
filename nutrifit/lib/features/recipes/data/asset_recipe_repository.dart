import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/errors/failure.dart';
import '../domain/recipe.dart';
import '../domain/recipe_repository.dart';

/// Reads the bundled catalogue (`assets/recipes/recipes.json`).
class AssetRecipeRepository implements RecipeRepository {
  AssetRecipeRepository({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  static const String assetPath = 'assets/recipes/recipes.json';

  final AssetBundle _bundle;

  @override
  Future<List<Recipe>> loadAll() async {
    try {
      final raw = await _bundle.loadString(assetPath);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return [
        for (final item in decoded['recipes'] as List<Object?>)
          Recipe.fromJson(item! as Map<String, dynamic>),
      ];
    } catch (e) {
      throw Failure.unknown(message: e.toString());
    }
  }
}
