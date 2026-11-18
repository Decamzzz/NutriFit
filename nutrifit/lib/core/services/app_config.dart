/// Backend endpoints/keys. Values are publishable client keys
/// (they ship inside the app binary by design). --dart-define overrides
/// these defaults, e.g. for CI or staging:
/// flutter run --dart-define SUPABASE_URL=... --dart-define SUPABASE_ANON_KEY=...
/// flutter run --dart-define GEMINI_KEY=...   (alias of GEMINI_API_KEY)
abstract final class AppConfig {
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://oqtjnmqnenxrfpuzrzad.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xdGpubXFuZW54cmZwdXpyemFkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTE0ODg4NzAsImV4cCI6MjEwNzA2NDg3MH0.YdquEZc9FGt8ztIVc-qpiQqhO9QHa-woOAZuH_Hkiy8',
  );
  static const geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

  /// Alias accepted in the plan: `--dart-define GEMINI_KEY=...`.
  /// Takes precedence over [geminiApiKey] when provided.
  static const geminiApiKeyAlias = String.fromEnvironment('GEMINI_KEY');

  static String get effectiveGeminiKey =>
      geminiApiKeyAlias.isNotEmpty ? geminiApiKeyAlias : geminiApiKey;

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  static bool get hasGemini => effectiveGeminiKey.isNotEmpty;
}
