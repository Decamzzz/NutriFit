import '../domain/diary_entry.dart';
import '../domain/meal_type.dart';

/// Static seed for add-food screen (screen3), matching reference design.
/// Fase 3 may move this to Supabase without touching the UI.
class FrequentFood {
  const FrequentFood({
    required this.name,
    required this.portion,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.meals,
  });

  final String name;
  final String portion;
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final Set<MealType> meals;

  DiaryEntry toEntry({required String date, required MealType meal}) =>
      DiaryEntry(
        date: date,
        mealType: meal.tableValue,
        foodName: name,
        grams: 100,
        kcal: kcal,
        protein: protein,
        carbs: carbs,
        fat: fat,
        source: 'manual',
      );
}

const List<FrequentFood> kFrequentFoods = [
  FrequentFood(
    name: 'Huevo entero cocido',
    portion: '2 unidades medianas',
    kcal: 155,
    protein: 13,
    carbs: 1,
    fat: 11,
    meals: {MealType.breakfast, MealType.snack},
  ),
  FrequentFood(
    name: 'Palta (Aguacate)',
    portion: '100 gramos',
    kcal: 160,
    protein: 2,
    carbs: 9,
    fat: 15,
    meals: {MealType.breakfast, MealType.lunch, MealType.dinner},
  ),
  FrequentFood(
    name: 'Pechuga de pollo a la plancha',
    portion: '150 gramos',
    kcal: 165,
    protein: 31,
    carbs: 0,
    fat: 3.6,
    meals: {MealType.lunch, MealType.dinner},
  ),
  FrequentFood(
    name: 'Arroz integral cocido',
    portion: '150 gramos',
    kcal: 170,
    protein: 4,
    carbs: 35,
    fat: 1.5,
    meals: {MealType.lunch, MealType.dinner},
  ),
  FrequentFood(
    name: 'Avena cocida',
    portion: '200 gramos',
    kcal: 140,
    protein: 5,
    carbs: 24,
    fat: 2.5,
    meals: {MealType.breakfast, MealType.snack},
  ),
  FrequentFood(
    name: 'Yogur griego natural',
    portion: '170 gramos',
    kcal: 100,
    protein: 17,
    carbs: 6,
    fat: 0.7,
    meals: {MealType.breakfast, MealType.snack},
  ),
];
