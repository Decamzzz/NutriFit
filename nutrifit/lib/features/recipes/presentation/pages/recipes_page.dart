import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../providers/recipe_providers.dart';
import '../widgets/category_chips.dart';
import '../widgets/recipe_card.dart';

/// screen4: healthy recipe suggestions with calories, filtered by meal.
class RecipesPage extends ConsumerWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final recipesAsync = ref.watch(filteredRecipesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.healthyRecipes)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(strings.recipesSubtitle, style: theme.textTheme.bodyMedium),
          ),
          const CategoryChips(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              strings.recommendedForYou,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: recipesAsync.when(
              loading: () => AppLoader(label: strings.loading),
              error: (e, _) => AppErrorView(
                message: e.toString(),
                retryLabel: strings.retry,
                onRetry: () => ref.invalidate(recipesProvider),
              ),
              data: (recipes) {
                if (recipes.isEmpty) {
                  return Center(child: Text(strings.noRecipes));
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: recipes.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () => context.push('/recipe/${recipe.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
