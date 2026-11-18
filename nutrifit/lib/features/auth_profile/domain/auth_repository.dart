import 'body_profile_input.dart';

/// Auth contract. Implementations throw [Failure], never return it.
abstract class AuthRepository {
  Stream<String?> watchUserId();
  String? currentUserId();
  String? currentUserEmail();
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
    BodyProfileInput? body,
  });
  Future<void> signOut();
}
