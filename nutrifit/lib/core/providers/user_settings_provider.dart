import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_settings_port_impl.dart';
import '../models/user_settings.dart';
import '../ports/user_settings_port.dart';
import 'session_provider.dart';

part 'user_settings_provider.g.dart';

/// Backend access to the user profile. Override in tests.
@riverpod
UserSettingsPort userSettingsPort(Ref ref) => SupabaseUserSettingsPort();

/// Current user settings (null when signed out).
@riverpod
Future<UserSettings?> userSettings(Ref ref) async {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId.isEmpty) return null;
  return ref.watch(userSettingsPortProvider).load();
}

/// Keeps the settings in sync with Supabase Realtime so any change (this
/// device or another) is reflected without re-login.
@riverpod
Stream<void> userSettingsRealtimeSync(Ref ref) async* {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId.isEmpty) return;
  await for (final _ in ref.watch(userSettingsPortProvider).watchChanges()) {
    ref.invalidate(userSettingsProvider);
  }
}

/// Goal editor. Invalidates the cached settings on success.
@riverpod
class UserSettingsEditor extends _$UserSettingsEditor {
  @override
  FutureOr<void> build() {}

  Future<void> save({
    required String goal,
    required String activityLevel,
    required int calorieTarget,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(userSettingsPortProvider)
          .saveGoals(
            goal: goal,
            activityLevel: activityLevel,
            calorieTarget: calorieTarget,
          );
      ref.invalidate(userSettingsProvider);
    });
  }

  /// Saves height and/or goal weight (only the non-null values).
  Future<void> saveBodyData({double? heightCm, double? goalWeightKg}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(userSettingsPortProvider)
          .saveBodyData(heightCm: heightCm, goalWeightKg: goalWeightKg);
      ref.invalidate(userSettingsProvider);
    });
  }
}
