/// App-wide constants. Publishable keys live in AppConfig as
/// --dart-define defaults (client keys ship in the binary by design).
/// Never put service_role keys here.
abstract final class AppConstants {
  static const String appName = 'NutriFit';
  static const String supabaseUrlDefine = 'SUPABASE_URL';
  static const String supabaseAnonKeyDefine = 'SUPABASE_ANON_KEY';
  static const String geminiKeyDefine = 'GEMINI_API_KEY';

  static const String prefsThemeMode = 'theme_mode';
  static const String prefsLocale = 'locale_code';

  static const List<String> supportedLocales = ['es', 'en'];
}
