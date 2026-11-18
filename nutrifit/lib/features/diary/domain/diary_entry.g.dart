// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) => _DiaryEntry(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  date: json['date'] as String,
  mealType: json['meal_type'] as String,
  foodName: json['food_name'] as String,
  grams: (json['grams'] as num?)?.toDouble() ?? 100,
  kcal: (json['kcal'] as num?)?.toDouble() ?? 0,
  protein: (json['protein'] as num?)?.toDouble() ?? 0,
  carbs: (json['carbs'] as num?)?.toDouble() ?? 0,
  fat: (json['fat'] as num?)?.toDouble() ?? 0,
  source: json['source'] as String? ?? 'manual',
);

Map<String, dynamic> _$DiaryEntryToJson(_DiaryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'meal_type': instance.mealType,
      'food_name': instance.foodName,
      'grams': instance.grams,
      'kcal': instance.kcal,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'source': instance.source,
    };
