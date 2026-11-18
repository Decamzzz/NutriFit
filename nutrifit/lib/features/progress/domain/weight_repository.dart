import '../../../core/services/realtime_service.dart';
import 'weight_log.dart';

/// Weight log contract (public.weight_logs). Throws [Failure] on error.
abstract class WeightRepository {
  /// Every log of the current user, oldest first.
  Future<List<WeightLog>> fetchAll();

  /// Creates the log for [day] or replaces it (one weight per day).
  Future<WeightLog> save({required DateTime day, required double weightKg});

  Future<void> remove(String id);

  /// Row changes pushed by Supabase Realtime for the current user.
  Stream<RealtimeRowChange> watchChanges();
}
