import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/gemini_service.dart';
import '../domain/food_estimate.dart';
import '../domain/food_scan_repository.dart';
import 'food_estimate_parser.dart';

/// Gemini vision implementation. The photo is never uploaded to Supabase;
/// only the resulting numbers are stored in the diary.
class GeminiFoodScanner implements FoodScanRepository {
  GeminiFoodScanner({GenerativeModel? model})
    : _model = model ?? GeminiService.visionModelOrNull();

  final GenerativeModel? _model;

  static const String _prompt = '''
Eres un nutricionista visual. Analiza la foto de comida y devuelve SOLO un
array JSON, sin texto adicional, sin markdown y sin comentarios.

Formato exacto de cada elemento:
{
  "name": "nombre del alimento en español",
  "grams": 150,
  "kcal": 320,
  "protein": 20.5,
  "carbs": 30.2,
  "fat": 12.0,
  "confidence": 0.85
}

Reglas:
- "grams": porción estimada en gramos.
- "kcal": calorías de esa porción (no por 100 g).
- "protein", "carbs", "fat": gramos de esa porción.
- "confidence": entre 0 y 1.
- Si la imagen no contiene comida, devuelve [].
Ejemplo: [{"name":"Huevo cocido","grams":100,"kcal":155,"protein":13,"carbs":1,"fat":11,"confidence":0.9}]
''';

  @override
  Future<List<FoodEstimate>> scanFood({
    required Uint8List imageBytes,
    required String mimeType,
  }) async {
    final model = _model;
    if (model == null) {
      throw const Failure.unknown(message: 'no-gemini-key');
    }
    try {
      final response = await model.generateContent(
        [
          Content.multi([
            TextPart(_prompt),
            DataPart(mimeType, imageBytes),
          ]),
        ],
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.2,
        ),
      );
      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        throw const Failure.unknown(message: 'empty-response');
      }
      if (kDebugMode) {
        debugPrint(
          '[NutriFit] Gemini -> ${text.substring(0, text.length > 500 ? 500 : text.length)}',
        );
      }
      return FoodEstimateParser.parse(text);
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure.unknown(message: e.toString());
    }
  }
}
