import 'diary_entry.dart';

/// Summed nutrients for a day. Plain immutable value object (no codegen).
class MacroTotals {
  const MacroTotals({
    this.kcal = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
  });

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;

  static MacroTotals fromEntries(Iterable<DiaryEntry> entries) {
    var kcal = 0.0, protein = 0.0, carbs = 0.0, fat = 0.0;
    for (final e in entries) {
      kcal += e.kcal;
      protein += e.protein;
      carbs += e.carbs;
      fat += e.fat;
    }
    return MacroTotals(
      kcal: kcal,
      protein: protein,
      carbs: carbs,
      fat: fat,
    );
  }

  MacroTotals operator +(MacroTotals other) => MacroTotals(
    kcal: kcal + other.kcal,
    protein: protein + other.protein,
    carbs: carbs + other.carbs,
    fat: fat + other.fat,
  );
}
