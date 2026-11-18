import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/session_provider.dart';
import '../../../../core/providers/user_settings_provider.dart';
import '../../data/weight_repository_impl.dart';
import '../../domain/weight_log.dart';
import '../../domain/weight_repository.dart';
import '../../domain/weight_summary.dart';

part 'weight_providers.g.dart';

/// Backend access to the weight logs. Override in tests.
@riverpod
WeightRepository weightRepository(Ref ref) => SupabaseWeightRepository();

/// All the weight logs of the current user (oldest first).
@riverpod
Future<List<WeightLog>> weightLogs(Ref ref) async {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId.isEmpty) return const [];
  return ref.watch(weightRepositoryProvider).fetchAll();
}

/// Logs + height + goal weight, ready for the progress screen.
@riverpod
Future<WeightSummary> weightSummary(Ref ref) async {
  final logs = await ref.watch(weightLogsProvider.future);
  final settings = await ref.watch(userSettingsProvider.future);
  return WeightSummary.from(
    logs: logs,
    heightCm: settings?.heightCm,
    goalWeightKg: settings?.goalWeightKg,
  );
}

/// Keeps the logs in sync with Supabase Realtime (this or another device).
@riverpod
Stream<void> weightRealtimeSync(Ref ref) async* {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId.isEmpty) return;
  await for (final _ in ref.watch(weightRepositoryProvider).watchChanges()) {
    ref.invalidate(weightLogsProvider);
  }
}

/// Add / replace / remove controller. UI watches the AsyncValue.
@riverpod
class WeightEditor extends _$WeightEditor {
  @override
  FutureOr<void> build() {}

  Future<void> save({required DateTime day, required double weightKg}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(weightRepositoryProvider)
          .save(day: day, weightKg: weightKg);
      ref.invalidate(weightLogsProvider);
    });
  }

  Future<void> remove(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(weightRepositoryProvider).remove(id);
      ref.invalidate(weightLogsProvider);
    });
  }
}
