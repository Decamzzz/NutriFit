import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

/// User preferences that several features depend on (diary target, progress
/// goals, profile page). Lives in core so no feature imports another.
@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String id,
    String? email,
    String? name,
    @Default('maintain') String goal,
    @JsonKey(name: 'activity_level') @Default('moderate') String activityLevel,
    @JsonKey(name: 'calorie_target') @Default(2200) int calorieTarget,
    @JsonKey(name: 'height_cm') double? heightCm,
    @JsonKey(name: 'goal_weight_kg') double? goalWeightKg,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
