import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrifit/core/providers/session_provider.dart';
import 'package:nutrifit/features/auth_profile/domain/auth_repository.dart';
import 'package:nutrifit/features/auth_profile/domain/body_profile_input.dart';
import 'package:nutrifit/features/auth_profile/presentation/pages/login_page.dart';
import 'package:nutrifit/features/auth_profile/presentation/providers/auth_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fake repository that accepts the credentials without touching Supabase.
class _FakeAuthRepository implements AuthRepository {
  BodyProfileInput? lastSignUpBody;

  @override
  Stream<String> watchUserId() => const Stream.empty();

  @override
  String? currentUserId() => 'uid-1';

  @override
  String? currentUserEmail() => 'carlos@mail.com';

  @override
  Future<void> signIn({required String email, required String password}) async {}

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
    BodyProfileInput? body,
  }) async {
    lastSignUpBody = body;
  }

  @override
  Future<void> signOut() async {}
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets(
    'regression: login navigates even when the session id does not change',
    (tester) async {
      final router = GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
          GoRoute(
            path: '/home',
            builder: (_, _) => const Scaffold(body: Text('HOME')),
          ),
        ],
      );
      addTearDown(router.dispose);

      final container = ProviderContainer(
        overrides: [
          // The session was already restored before the login page exists,
          // so the user id never changes: a stream based navigation would
          // never fire.
          authUserIdStreamProvider.overrideWith((ref) => Stream.value('uid-1')),
          authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(
        sessionUserIdProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);
      await tester.pump();
      expect(container.read(sessionUserIdProvider), 'uid-1');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'carlos@mail.com',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'password123',
      );
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      await tester.pump();

      expect(find.text('HOME'), findsOneWidget);
    },
  );

  testWidgets('register: previews the BMI and sends the body data', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final fake = _FakeAuthRepository();
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
        GoRoute(
          path: '/home',
          builder: (_, _) => const Scaffold(body: Text('HOME')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(fake)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('¿No tienes cuenta? Regístrate'));
    await tester.pump();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Carlos');
    await tester.enterText(fields.at(1), 'carlos@mail.com');
    await tester.enterText(fields.at(2), 'password123');
    await tester.enterText(fields.at(3), 'password123');
    await tester.enterText(fields.at(4), '76,8');
    await tester.enterText(fields.at(5), '175');
    await tester.pump();

    expect(find.textContaining('Tu IMC: 25.1'), findsOneWidget);

    await tester.tap(find.text('Perder grasa corporal'));
    await tester.pump();
    await tester.enterText(find.byType(TextFormField).at(6), '70');
    await tester.pump();

    await tester.tap(find.text('Crear cuenta'));
    await tester.pump();
    await tester.pump();

    final body = fake.lastSignUpBody;
    expect(body, isNotNull);
    expect(body!.weightKg, 76.8);
    expect(body.heightCm, 175);
    expect(body.goal, 'lose');
    expect(body.goalWeightKg, 70);
    expect(find.text('HOME'), findsOneWidget);
  });
}
