import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nutrifit/app/app.dart';

void main() {
  testWidgets('NutriFitApp builds onboarding by default', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: NutriFitApp()));
    await tester.pump(const Duration(seconds: 1));
    // Onboarding copy comes from i18n (ES default), not hardcoded widgets.
    // The brand name is part of the logo image, so check the title instead.
    expect(find.text('Tu plan de nutrición inteligente'), findsOneWidget);
  });
}
