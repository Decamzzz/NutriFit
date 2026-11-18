/// Meal slots matching screen2/screen3 mockups + DB check constraint.
enum MealType { breakfast, lunch, dinner, snack }

extension MealTypeX on MealType {
  static MealType parse(String raw) => MealType.values.firstWhere(
    (m) => m.name == raw,
    orElse: () => MealType.snack,
  );

  String get tableValue => name;
}
