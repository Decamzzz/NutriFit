import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/supabase_service.dart';

part 'session_provider.g.dart';

/// Source of the auth session events. Overridable in tests.
///
/// It is a plain [Provider] (not a StreamProvider) so that consumers get the
/// raw [Stream] instead of an AsyncValue.
final authUserIdStreamProvider = Provider<Stream<String>>(
  (ref) => SupabaseService.authUserIdStream(),
);

/// Current user id ('' when signed out).
///
/// The subscription is owned by this notifier and kept alive for the whole
/// app session, so the value is stable: the router guard, the realtime
/// syncs and the auth flows always agree on the same state.
///
/// The initial value comes from the restored session (synchronous), and the
/// stream keeps it up to date on every auth event.
@riverpod
class SessionUserId extends _$SessionUserId {
  @override
  String build() {
    ref.keepAlive();
    final StreamSubscription<String> subscription = ref
        .watch(authUserIdStreamProvider)
        .listen((id) => state = id);
    ref.onDispose(subscription.cancel);
    return SupabaseService.currentUserId ?? '';
  }
}
