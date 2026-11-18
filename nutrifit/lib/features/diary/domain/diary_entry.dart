import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_entry.freezed.dart';
part 'diary_entry.g.dart';

/// One row of public.diary_entries. Numeric fields are doubles in Dart
/// (numeric in Postgres).
@freezed
abstract class DiaryEntry with _$DiaryEntry {
  const factory DiaryEntry({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    required String date,
    @JsonKey(name: 'meal_type') required String mealType,
    @JsonKey(name: 'food_name') required String foodName,
    @Default(100) double grams,
    @Default(0) double kcal,
    @Default(0) double protein,
    @Default(0) double carbs,
    @Default(0) double fat,
    @Default('manual') String source,
  }) = _DiaryEntry;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
}
