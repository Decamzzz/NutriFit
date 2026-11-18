/// Recipe groups; they match the meal tabs of the screen4 mockup.
enum RecipeCategory { breakfast, lunch, dinner, snack }

extension RecipeCategoryX on RecipeCategory {
  /// Null when [raw] is not a known category.
  static RecipeCategory? tryParse(String raw) {
    for (final category in RecipeCategory.values) {
      if (category.name == raw) return category;
    }
    return null;
  }
}
