import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/app/app.dart';
import 'package:nutrifit/core/providers/session_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('signed out: the app starts on the onboarding', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authUserIdStreamProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const NutriFitApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Tu plan de nutrición inteligente'), findsOneWidget);
  });

  testWidgets('restored session: the app skips onboarding and login', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authUserIdStreamProvider.overrideWith((ref) => Stream.value('uid-1')),
        ],
        child: const NutriFitApp(),
      ),
    );
    await tester.pump();
    await tester.pump();

    // The user is already signed in: neither onboarding nor login is shown.
    expect(find.text('Tu plan de nutrición inteligente'), findsNothing);
    expect(find.text('Iniciar sesión'), findsNothing);
  });
}
