import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_estimate.freezed.dart';
part 'food_estimate.g.dart';

/// One food detected by the AI scan. Editable before saving to the diary.
@freezed
abstract class FoodEstimate with _$FoodEstimate {
  const factory FoodEstimate({
    required String name,
    @Default(100) double grams,
    @Default(0) double kcal,
    @Default(0) double protein,
    @Default(0) double carbs,
    @Default(0) double fat,
    @Default(0.5) double confidence,
  }) = _FoodEstimate;

  factory FoodEstimate.fromJson(Map<String, dynamic> json) =>
      _$FoodEstimateFromJson(json);
}
