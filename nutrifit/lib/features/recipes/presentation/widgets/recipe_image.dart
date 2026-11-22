import 'package:flutter/material.dart';

import '../../domain/recipe.dart';

/// Recipe picture loaded from the bundled `lib/recipes_pictures/` folder.
///
/// Falls back to the recipe emoji when the asset is missing or cannot be
/// decoded, so the catalogue keeps working without pictures.
class RecipeImage extends StatelessWidget {
  const RecipeImage({
    super.key,
    required this.recipe,
    this.height = 120,
    this.borderRadius = BorderRadius.zero,
  });

  final Recipe recipe;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final fallback = _EmojiFallback(recipe: recipe, height: height);
    final picture = recipe.image.isEmpty
        ? fallback
        : Image.asset(
            recipe.image,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => fallback,
          );
    return ClipRRect(borderRadius: borderRadius, child: picture);
  }
}

class _EmojiFallback extends StatelessWidget {
  const _EmojiFallback({required this.recipe, required this.height});

  final Recipe recipe;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primaryContainer, scheme.secondaryContainer],
        ),
      ),
      child: Text(recipe.emoji, style: TextStyle(fontSize: height * 0.4)),
    );
  }
}
