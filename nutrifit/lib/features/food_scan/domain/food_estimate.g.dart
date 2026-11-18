// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FoodEstimate _$FoodEstimateFromJson(Map<String, dynamic> json) =>
    _FoodEstimate(
      name: json['name'] as String,
      grams: (json['grams'] as num?)?.toDouble() ?? 100,
      kcal: (json['kcal'] as num?)?.toDouble() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$FoodEstimateToJson(_FoodEstimate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'grams': instance.grams,
      'kcal': instance.kcal,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'confidence': instance.confidence,
    };
