import '../../../core/services/realtime_service.dart';
import 'diary_entry.dart';
import 'meal_type.dart';

/// Diary contract (public.diary_entries). Throws [Failure] on error.
abstract class DiaryRepository {
  Future<List<DiaryEntry>> fetchDay(DateTime day);
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
  });
  Future<void> removeEntry(String id);

  /// Row changes pushed by Supabase Realtime for the current user.
  Stream<RealtimeRowChange> watchChanges();
}
