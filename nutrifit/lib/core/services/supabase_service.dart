import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_config.dart';

/// Guards Supabase init so the app runs (in degraded mode) without keys,
/// which is useful for university demos and widget tests.
abstract final class SupabaseService {
  static bool _ready = false;
  static bool get isReady => _ready;

  static Future<void> init() async {
    if (!AppConfig.hasSupabase) return;
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      // ignore: deprecated_member_use
      anonKey: AppConfig.supabaseAnonKey,
    );
    _ready = true;
  }

  static SupabaseClient? get clientOrNull =>
      _ready ? Supabase.instance.client : null;

  /// User id of the active session, or null when signed out.
  static String? get currentUserId =>
      clientOrNull?.auth.currentSession?.user.id;

  /// Email of the active session, or null when signed out.
  static String? get currentUserEmail =>
      clientOrNull?.auth.currentSession?.user.email;

  /// Emits the user id on every auth state change ('' when signed out).
  static Stream<String> authUserIdStream() {
    final client = clientOrNull;
    if (client == null) return const Stream<String>.empty();
    return client.auth.onAuthStateChange.map(
      (s) => s.session?.user.id ?? '',
    );
  }
}
