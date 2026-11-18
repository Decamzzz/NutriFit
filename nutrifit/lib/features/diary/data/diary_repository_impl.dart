import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/realtime_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/utils/date_utils.dart';
import '../domain/diary_entry.dart';
import '../domain/diary_repository.dart';
import '../domain/meal_type.dart';

/// public.diary_entries implementation.
class SupabaseDiaryRepository implements DiaryRepository {
  SupabaseClient get _client {
    final client = SupabaseService.clientOrNull;
    if (client == null) throw const Failure.unknown(message: 'no-backend');
    return client;
  }

  @override
  Future<List<DiaryEntry>> fetchDay(DateTime day) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    try {
      final rows = await _client
          .from('diary_entries')
          .select()
          .eq('user_id', userId)
          .eq('date', ymd(day))
          .order('created_at', ascending: true);
      return rows
          .map((e) => DiaryEntry.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      if (e is Failure) rethrow;
      throw const Failure.network();
    }
  }

  @override
  Future<DiaryEntry> addEntry({
    required DateTime day,
    required MealType meal,
    required String foodName,
    required double grams,
    required double kcal,
    required double protein,
    required double carbs,
    required double fat,
    String source = 'manual',
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    if (foodName.trim().isEmpty) {
      throw const Failure.validation(message: 'empty-food');
    }
    try {
      final rows = await _client
          .from('diary_entries')
          .insert({
            'user_id': userId,
            'date': ymd(day),
            'meal_type': meal.tableValue,
            'food_name': foodName.trim(),
            'grams': grams,
            'kcal': kcal,
            'protein': protein,
            'carbs': carbs,
            'fat': fat,
            'source': source,
          })
          .select();
      final list = List<Map<String, dynamic>>.from(
        rows.map((e) => Map<String, dynamic>.from(e as Map)),
      );
      return DiaryEntry.fromJson(list.first);
    } catch (e) {
      if (e is Failure) rethrow;
      throw const Failure.network();
    }
  }

  @override
  Future<void> removeEntry(String id) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) throw const Failure.auth();
    try {
      await _client
          .from('diary_entries')
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
      table: 'diary_entries',
      userColumn: 'user_id',
      userId: userId,
    );
  }
}
