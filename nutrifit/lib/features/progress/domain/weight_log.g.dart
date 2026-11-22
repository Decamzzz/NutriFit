// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeightLog _$WeightLogFromJson(Map<String, dynamic> json) => _WeightLog(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  date: json['date'] as String,
  weightKg: (json['weight_kg'] as num).toDouble(),
);

Map<String, dynamic> _$WeightLogToJson(_WeightLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'weight_kg': instance.weightKg,
    };
