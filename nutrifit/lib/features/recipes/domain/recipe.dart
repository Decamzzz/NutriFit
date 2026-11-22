import 'localized_text.dart';
import 'recipe_category.dart';

/// A suggested recipe. Nutrition values are approximate and per serving.
class Recipe {
  const Recipe({
    required this.id,
    required this.category,
    required this.emoji,
    required this.image,
    required this.minutes,
    required this.grams,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  /// Throws [FormatException] when a required field is missing or malformed.
  factory Recipe.fromJson(Map<String, dynamic> json) {
    final rawCategory = json['category'] as String;
    final category = RecipeCategoryX.tryParse(rawCategory);
    if (category == null) {
      throw FormatException('Unknown recipe category: $rawCategory');
    }
    return Recipe(
      id: json['id'] as String,
      category: category,
      emoji: json['emoji'] as String,
      // Bundled picture (assets/); empty means "use the emoji fallback".
      image: json['image'] as String? ?? '',
      minutes: (json['minutes'] as num).toInt(),
      grams: (json['grams'] as num).toDouble(),
      kcal: (json['kcal'] as num).toInt(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      name: LocalizedText.fromJson(json['name'] as Map<String, dynamic>),
      description: LocalizedText.fromJson(
        json['description'] as Map<String, dynamic>,
      ),
      ingredients: _texts(json['ingredients']),
      steps: _texts(json['steps']),
    );
  }

  final String id;
  final RecipeCategory category;
  final String emoji;

  /// Asset key of the recipe picture (e.g. `lib/recipes_pictures/arepa.jpg`).
  final String image;
  final int minutes;

  /// Approximate weight of one serving, in grams.
  final double grams;
  final int kcal;
  final double protein;
  final double carbs;
  final double fat;
  final LocalizedText name;
  final LocalizedText description;
  final List<LocalizedText> ingredients;
  final List<LocalizedText> steps;

  static List<LocalizedText> _texts(Object? raw) => [
    for (final item in raw! as List<Object?>)
      LocalizedText.fromJson(item! as Map<String, dynamic>),
  ];
}
