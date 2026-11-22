import 'package:supabase_flutter/supabase_flutter.dart';

import '../errors/failure.dart';
import '../models/user_settings.dart';
import '../ports/user_settings_port.dart';
import '../services/realtime_service.dart';
import '../services/supabase_service.dart';
import '../utils/body_metrics.dart';

/// Supabase implementation of the `profiles` table.
class SupabaseUserSettingsPort implements UserSettingsPort {
  SupabaseClient get _client {
    final client = SupabaseService.clientOrNull;
    if (client == null) throw const Failure.unknown(message: 'no-backend');
    return client;
  }

  @override
  Future<UserSettings?> load() async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) return null;
    try {
      final row = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      if (row == null) return null;
      return UserSettings.fromJson(Map<String, dynamic>.from(row));
    } on Failure {
      rethrow;
    } catch (_) {
      throw const Failure.network();
    }
  }

  @override
  Future<UserSettings> saveGoals({
    required String goal,
    required String activityLevel,
    required int calorieTarget,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    try {
      final rows = await _client
          .from('profiles')
          .update({
            'goal': goal,
            'activity_level': activityLevel,
            'calorie_target': calorieTarget,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId)
          .select();
      final list = List<Map<String, dynamic>>.from(
        rows.map((e) => Map<String, dynamic>.from(e as Map)),
      );
      if (list.isEmpty) throw const Failure.unknown();
      return UserSettings.fromJson(list.first);
    } on Failure {
      rethrow;
    } catch (_) {
      throw const Failure.network();
    }
  }

  @override
  Future<UserSettings> saveBodyData({
    double? heightCm,
    double? goalWeightKg,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    if (heightCm != null && !isValidHeightCm(heightCm)) {
      throw const Failure.validation(message: 'invalid-height');
    }
    if (goalWeightKg != null && !isValidWeightKg(goalWeightKg)) {
      throw const Failure.validation(message: 'invalid-goal-weight');
    }
    final changes = <String, Object>{
      'height_cm': ?heightCm,
      'goal_weight_kg': ?goalWeightKg,
    };
    if (changes.isEmpty) {
      throw const Failure.validation(message: 'nothing-to-save');
    }
    try {
      final rows = await _client
          .from('profiles')
          .update({...changes, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', userId)
          .select();
      final list = List<Map<String, dynamic>>.from(
        rows.map((e) => Map<String, dynamic>.from(e as Map)),
      );
      if (list.isEmpty) throw const Failure.unknown();
      return UserSettings.fromJson(list.first);
    } on Failure {
      rethrow;
    } catch (_) {
      throw const Failure.network();
    }
  }

  @override
  Stream<RealtimeRowChange> watchChanges() {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) return const Stream<RealtimeRowChange>.empty();
    return RealtimeService.watchTable(
      table: 'profiles',
      userColumn: 'id',
      userId: userId,
    );
  }
}
