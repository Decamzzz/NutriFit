import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../data/auth_repository_impl.dart';
import '../../domain/auth_repository.dart';
import '../../domain/body_profile_input.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => SupabaseAuthRepository();

@riverpod
String? currentUserEmail(Ref ref) =>
    SupabaseService.currentUserEmail;

/// Login/register/logout controller. UI handles AsyncValue states.
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  /// Returns true when the credentials were accepted.
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
    });
    state = result;
    return !result.hasError;
  }

  /// Returns true when the account was created.
  Future<bool> signUp({
    required String email,
    required String password,
    String? name,
    BodyProfileInput? body,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password, name: name, body: body);
    });
    state = result;
    return !result.hasError;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
