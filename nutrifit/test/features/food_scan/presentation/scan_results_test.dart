import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/features/food_scan/domain/food_estimate.dart';
import 'package:nutrifit/features/food_scan/presentation/widgets/scan_results.dart';

void main() {
  testWidgets('ScanResults shows the detected foods and the action', (
    tester,
  ) async {
    var tapped = false;
    const estimates = [
      FoodEstimate(
        name: 'Huevo cocido',
        grams: 100,
        kcal: 155,
        protein: 13,
        carbs: 1,
        fat: 11,
        confidence: 0.9,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScanResults(
            estimates: estimates,
            title: 'Alimentos detectados',
            actionLabel: 'Agregar al diario',
            onAddToDiary: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Alimentos detectados'), findsOneWidget);
    expect(find.text('Huevo cocido'), findsOneWidget);
    expect(find.text('155 kcal'), findsOneWidget);
    expect(find.text('Agregar al diario'), findsOneWidget);

    await tester.tap(find.text('Agregar al diario'));
    expect(tapped, isTrue);
  });
}
