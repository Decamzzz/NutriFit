import '../models/user_settings.dart';
import '../services/realtime_service.dart';

/// Port for the `profiles` table. Implemented in core (Supabase) and
/// replaceable in tests.
abstract class UserSettingsPort {
  Future<UserSettings?> load();
  Future<UserSettings> saveGoals({
    required String goal,
    required String activityLevel,
    required int calorieTarget,
  });
  /// Updates only the body fields that are non-null.
  Future<UserSettings> saveBodyData({double? heightCm, double? goalWeightKg});
  Stream<RealtimeRowChange> watchChanges();
}
