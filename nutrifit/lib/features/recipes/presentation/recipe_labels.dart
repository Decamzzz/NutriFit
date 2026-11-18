import '../../../core/l10n/app_strings.dart';
import '../domain/recipe_category.dart';

/// Localized name of a recipe category (reuses the meal names).
String recipeCategoryLabel(AppStrings strings, RecipeCategory category) =>
    switch (category) {
      RecipeCategory.breakfast => strings.breakfast,
      RecipeCategory.lunch => strings.lunch,
      RecipeCategory.dinner => strings.dinner,
      RecipeCategory.snack => strings.snack,
    };
