import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/core/errors/failure.dart';
import 'package:nutrifit/features/food_scan/data/food_estimate_parser.dart';

void main() {
  group('FoodEstimateParser', () {
    test('parses a clean JSON array', () {
      const raw = '''
[{"name":"Huevo cocido","grams":100,"kcal":155,"protein":13,"carbs":1,"fat":11,"confidence":0.9}]
''';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates, hasLength(1));
      expect(estimates.first.name, 'Huevo cocido');
      expect(estimates.first.grams, 100);
      expect(estimates.first.kcal, 155);
      expect(estimates.first.protein, 13);
      expect(estimates.first.confidence, 0.9);
    });

    test('parses markdown fenced answer', () {
      const raw = '''
```json
[{"name":"Arroz integral","grams":150,"kcal":170,"protein":4,"carbs":35,"fat":1.5,"confidence":0.8}]
```
''';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates.single.name, 'Arroz integral');
      expect(estimates.single.carbs, 35);
    });

    test('parses answer with surrounding prose', () {
      const raw = '''
Claro, aquí tienes el análisis:
[{"name":"Pollo","grams":150,"kcal":165,"protein":31,"carbs":0,"fat":3.6,"confidence":0.75}]
Espero que te sirva.
''';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates.single.name, 'Pollo');
      expect(estimates.single.fat, closeTo(3.6, 0.001));
    });

    test('accepts a single object answer', () {
      const raw = '{"name":"Yogur","grams":170,"kcal":100}';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates.single.name, 'Yogur');
      expect(estimates.single.kcal, 100);
      expect(estimates.single.protein, 0);
    });

    test('parses numeric strings and clamps confidence', () {
      const raw = '[{"name":"Pan","grams":"80","kcal":"220","confidence":5}]';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates.single.grams, 80);
      expect(estimates.single.kcal, 220);
      expect(estimates.single.confidence, 1.0);
    });

    test('skips items without a name', () {
      const raw = '[{"grams":10},{"name":"Agua","kcal":0}]';
      final estimates = FoodEstimateParser.parse(raw);
      expect(estimates, hasLength(1));
      expect(estimates.single.name, 'Agua');
    });

    test('throws Failure on invalid JSON', () {
      expect(
        () => FoodEstimateParser.parse('no json here'),
        throwsA(isA<Failure>()),
      );
    });

    test('throws Failure on empty array', () {
      expect(
        () => FoodEstimateParser.parse('[]'),
        throwsA(isA<Failure>()),
      );
    });
  });
}
