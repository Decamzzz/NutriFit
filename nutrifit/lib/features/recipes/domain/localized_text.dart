/// A text available in every language of the app (recipe content is data,
/// not UI chrome, so it lives in the JSON instead of `AppStrings`).
class LocalizedText {
  const LocalizedText({required this.es, required this.en});

  factory LocalizedText.fromJson(Map<String, dynamic> json) =>
      LocalizedText(es: json['es'] as String, en: json['en'] as String);

  final String es;
  final String en;

  /// Text for a language code such as `es`, `en` or `en-US` (default: es).
  String of(String languageCode) => languageCode.startsWith('en') ? en : es;
}
