import 'package:google_generative_ai/google_generative_ai.dart';

import 'app_config.dart';

/// Thin factory for the Gemini vision model. Features use repositories,
/// never this client directly.
abstract final class GeminiService {
  static GenerativeModel? visionModelOrNull() {
    if (!AppConfig.hasGemini) return null;
    return GenerativeModel(
      model: 'gemini-3.5-flash-lite',
      apiKey: AppConfig.effectiveGeminiKey,
    );
  }
}
