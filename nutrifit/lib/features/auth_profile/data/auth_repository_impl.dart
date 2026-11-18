import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/utils/date_utils.dart';
import '../domain/auth_repository.dart';
import '../domain/body_profile_input.dart';

/// Supabase Auth implementation. UI never touches Supabase directly.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client {
    final client = SupabaseService.clientOrNull;
    if (client == null) throw const Failure.unknown(message: 'no-backend');
    return client;
  }

  @override
  Stream<String?> watchUserId() => _client.auth.onAuthStateChange.map(
    (s) => s.session?.user.id,
  );

  @override
  String? currentUserId() => _client.auth.currentSession?.user.id;

  @override
  String? currentUserEmail() => _client.auth.currentSession?.user.email;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Failure.auth(message: e.message);
    } catch (_) {
      throw const Failure.network();
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
    BodyProfileInput? body,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          if (name != null && name.isNotEmpty) 'name': name,
          if (body != null) ..._bodyMetadata(body),
        },
      );
    } on AuthException catch (e) {
      throw Failure.auth(message: e.message);
    } catch (_) {
      throw const Failure.network();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (_) {
      throw const Failure.network();
    }
  }

  /// Keys read by the `handle_new_user` trigger (see the Fase 3 migration).
  /// The weight date is the user's local day: the server runs in UTC.
  Map<String, Object> _bodyMetadata(BodyProfileInput body) => {
    'weight_kg': body.weightKg,
    'height_cm': body.heightCm,
    'goal': body.goal,
    'goal_weight_kg': body.goalWeightKg,
    'weight_date': ymd(DateTime.now()),
  };
}
