/// Feature-agnostic nutrition item used to move food data between features
/// (e.g. AI scan result -> diary write) without coupling them.
class NutritionItem {
  const NutritionItem({
    required this.name,
    required this.grams,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  final String name;
  final double grams;
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
}
