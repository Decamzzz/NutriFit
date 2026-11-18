// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) =>
    _UserSettings(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      goal: json['goal'] as String? ?? 'maintain',
      activityLevel: json['activity_level'] as String? ?? 'moderate',
      calorieTarget: (json['calorie_target'] as num?)?.toInt() ?? 2200,
    );

Map<String, dynamic> _$UserSettingsToJson(_UserSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'goal': instance.goal,
      'activity_level': instance.activityLevel,
      'calorie_target': instance.calorieTarget,
    };
