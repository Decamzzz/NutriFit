import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/features/diary/domain/diary_entry.dart';
import 'package:nutrifit/features/diary/domain/macro_totals.dart';
import 'package:nutrifit/features/diary/domain/meal_type.dart';
import 'package:nutrifit/features/diary/presentation/providers/diary_providers.dart'
    show mealEntriesSync;

void main() {
  test('MealTypeX.parse falls back to snack on unknown', () {
    expect(MealTypeX.parse('breakfast'), MealType.breakfast);
    expect(MealTypeX.parse('dinner'), MealType.dinner);
    expect(MealTypeX.parse('nope'), MealType.snack);
  });

  test('MacroTotals.fromEntries sums nutrients', () {
    const entries = [
      DiaryEntry(
        date: '2026-10-12',
        mealType: 'breakfast',
        foodName: 'Huevo',
        kcal: 155,
        protein: 13,
        carbs: 1,
        fat: 11,
      ),
      DiaryEntry(
        date: '2026-10-12',
        mealType: 'lunch',
        foodName: 'Pollo',
        kcal: 165,
        protein: 31,
        carbs: 0,
        fat: 3.6,
      ),
    ];
    final totals = MacroTotals.fromEntries(entries);
    expect(totals.kcal, 320);
    expect(totals.protein, 44);
    expect(totals.carbs, 1);
    expect(totals.fat, closeTo(14.6, 0.001));
  });

  test('mealEntriesSync filters by slot', () {
    const entries = [
      DiaryEntry(
        date: '2026-10-12',
        mealType: 'breakfast',
        foodName: 'Huevo',
        kcal: 155,
      ),
      DiaryEntry(
        date: '2026-10-12',
        mealType: 'lunch',
        foodName: 'Pollo',
        kcal: 165,
      ),
    ];
    final breakfast = mealEntriesSync(entries, MealType.breakfast);
    expect(breakfast, hasLength(1));
    expect(breakfast.first.foodName, 'Huevo');
    expect(mealEntriesSync(entries, MealType.dinner), isEmpty);
  });

  test('DiaryEntry maps snake_case with defaults', () {
    final entry = DiaryEntry.fromJson({
      'date': '2026-10-12',
      'meal_type': 'snack',
      'food_name': 'Yogur',
      'kcal': 100,
    });
    expect(entry.mealType, 'snack');
    expect(entry.grams, 100);
    expect(entry.protein, 0);
    expect(entry.source, 'manual');
  });
}
