import '../../../../core/models/nutrition_item.dart';
import 'food_estimate.dart';

/// Maps the AI estimate to the transport DTO shared with other features.
extension FoodEstimateX on FoodEstimate {
  NutritionItem toItem() => NutritionItem(
    name: name,
    grams: grams,
    kcal: kcal,
    protein: protein,
    carbs: carbs,
    fat: fat,
  );
}
