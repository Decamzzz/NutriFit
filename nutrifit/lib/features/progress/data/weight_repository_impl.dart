import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/realtime_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/utils/body_metrics.dart';
import '../../../core/utils/date_utils.dart';
import '../domain/weight_log.dart';
import '../domain/weight_repository.dart';

/// public.weight_logs implementation (one row per user and day).
class SupabaseWeightRepository implements WeightRepository {
  SupabaseClient get _client {
    final client = SupabaseService.clientOrNull;
    if (client == null) throw const Failure.unknown(message: 'no-backend');
    return client;
  }

  @override
  Future<List<WeightLog>> fetchAll() async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    try {
      final rows = await _client
          .from('weight_logs')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: true);
      return rows
          .map((e) => WeightLog.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      if (e is Failure) rethrow;
      throw const Failure.network();
    }
  }

  @override
  Future<WeightLog> save({
    required DateTime day,
    required double weightKg,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    if (!isValidWeightKg(weightKg)) {
      throw const Failure.validation(message: 'invalid-weight');
    }
    try {
      final rows = await _client
          .from('weight_logs')
          .upsert({
            'user_id': userId,
            'date': ymd(day),
            'weight_kg': weightKg,
          }, onConflict: 'user_id,date')
          .select();
      final list = List<Map<String, dynamic>>.from(
        rows.map((e) => Map<String, dynamic>.from(e as Map)),
      );
      return WeightLog.fromJson(list.first);
    } catch (e) {
      if (e is Failure) rethrow;
      throw const Failure.network();
    }
  }

  @override
  Future<void> remove(String id) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    try {
      await _client
          .from('weight_logs')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      if (e is Failure) rethrow;
      throw const Failure.network();
    }
  }

  @override
  Stream<RealtimeRowChange> watchChanges() {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) return const Stream<RealtimeRowChange>.empty();
    return RealtimeService.watchTable(
      table: 'weight_logs',
      userColumn: 'user_id',
      userId: userId,
    );
  }
}
