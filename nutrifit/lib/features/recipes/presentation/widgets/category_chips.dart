import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../domain/recipe_category.dart';
import '../providers/recipe_providers.dart';
import '../recipe_labels.dart';

/// Horizontal filter tabs: All · Breakfast · Lunch · Dinner · Snacks.
class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final selected = ref.watch(recipeCategoryFilterProvider);
    final notifier = ref.read(recipeCategoryFilterProvider.notifier);

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ChoiceChip(
            label: Text(strings.filterAll),
            selected: selected == null,
            onSelected: (_) => notifier.select(null),
          ),
          for (final category in RecipeCategory.values) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              label: Text(recipeCategoryLabel(strings, category)),
              selected: selected == category,
              onSelected: (_) => notifier.select(category),
            ),
          ],
        ],
      ),
    );
  }
}
