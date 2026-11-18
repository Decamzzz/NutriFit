import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/models/user_settings.dart';

void main() {
  test('UserSettings maps snake_case columns with defaults', () {
    final settings = UserSettings.fromJson({
      'id': 'uid-1',
      'email': 'carlos@mail.com',
      'name': 'Carlos',
      'goal': 'lose',
      'activity_level': 'moderate',
      'calorie_target': 2200,
    });
    expect(settings.id, 'uid-1');
    expect(settings.goal, 'lose');
    expect(settings.activityLevel, 'moderate');
    expect(settings.calorieTarget, 2200);

    final minimal = UserSettings.fromJson({'id': 'uid-2'});
    expect(minimal.goal, 'maintain');
    expect(minimal.activityLevel, 'moderate');
    expect(minimal.calorieTarget, 2200);
  });

  test('UserSettings serializes back to snake_case', () {
    const settings = UserSettings(id: 'uid-3', activityLevel: 'active');
    final json = settings.toJson();
    expect(json['activity_level'], 'active');
    expect(json['calorie_target'], 2200);
  });

  test('UserSettings reads height and goal weight (nullable)', () {
    final full = UserSettings.fromJson({
      'id': 'uid-4',
      'height_cm': 175,
      'goal_weight_kg': 70.5,
    });
    expect(full.heightCm, 175.0);
    expect(full.goalWeightKg, 70.5);

    final legacy = UserSettings.fromJson({'id': 'uid-5'});
    expect(legacy.heightCm, isNull);
    expect(legacy.goalWeightKg, isNull);
  });
}
