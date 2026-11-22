import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/models/nutrition_item.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/recipe.dart';
import '../providers/recipe_providers.dart';
import '../recipe_labels.dart';
import '../widgets/macro_tile.dart';
import '../widgets/recipe_image.dart';

/// Recipe detail: calories, macros, ingredients and steps, plus a shortcut
/// to log it in the diary (reuses the diary's editable confirmation).
class RecipeDetailPage extends ConsumerWidget {
  const RecipeDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final recipeAsync = ref.watch(recipeByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text(strings.recipes)),
      body: recipeAsync.when(
        loading: () => AppLoader(label: strings.loading),
        error: (e, _) => AppErrorView(
          message: e.toString(),
          retryLabel: strings.retry,
          onRetry: () => ref.invalidate(recipesProvider),
        ),
        data: (recipe) => recipe == null
            ? Center(child: Text(strings.recipeNotFound))
            : _RecipeContent(recipe: recipe),
      ),
    );
  }
}

class _RecipeContent extends ConsumerWidget {
  const _RecipeContent({required this.recipe});

  final Recipe recipe;

  void _addToDiary(BuildContext context, String code) {
    final item = NutritionItem(
      name: recipe.name.of(code),
      grams: recipe.grams,
      kcal: recipe.kcal.toDouble(),
      protein: recipe.protein,
      carbs: recipe.carbs,
      fat: recipe.fat,
    );
    // Same editable confirmation used by the food scan; `source=recipe`
    // makes the diary entries be stored as coming from a recipe.
    context.push('/scan/confirm?source=recipe', extra: <NutritionItem>[item]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final code = ref.watch(localeSettingProvider).languageCode;
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RecipeImage(
            recipe: recipe,
            height: 200,
            borderRadius: BorderRadius.circular(16),
          ),
          const SizedBox(height: 16),
          Text(recipe.name.of(code), style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '${recipeCategoryLabel(strings, recipe.category)} · '
            '${strings.minutesValue(recipe.minutes)}',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(recipe.description.of(code)),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: [
                Text(
                  strings.kcalValue(recipe.kcal),
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MacroTile(
                      label: strings.proteins,
                      grams: recipe.protein,
                      color: AppColors.protein,
                    ),
                    MacroTile(
                      label: strings.carbs,
                      grams: recipe.carbs,
                      color: AppColors.carbs,
                    ),
                    MacroTile(
                      label: strings.fats,
                      grams: recipe.fat,
                      color: AppColors.fat,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(strings.perServing, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(strings.ingredients, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final ingredient in recipe.ingredients)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('•  ${ingredient.of(code)}'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(strings.preparation, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (index, step) in recipe.steps.indexed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          child: Text(
                            '${index + 1}',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(step.of(code))),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: strings.addToDiary,
            onPressed: () => _addToDiary(context, code),
          ),
        ],
      ),
    );
  }
}
