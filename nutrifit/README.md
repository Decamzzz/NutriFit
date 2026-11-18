# NutriFit

App móvil de seguimiento nutricional (tipo Fitia) para proyecto universitario.
Escaneo de comidas con IA, recetario, diario, gráficas de nutrición y progreso,
perfil con metas, i18n ES/EN y tema claro/oscuro.

## Stack

Flutter (stable) · Riverpod 3 (generator) · go_router · freezed · fl_chart ·
Supabase (Auth + Postgres + Realtime) · Google AI Studio (Gemini vision).

## Estructura

```
lib/
├── app/          # router, theme, providers de sesión/usuario
├── core/         # constants, errors, models, ports, providers, services, utils, widgets, l10n
└── features/     # auth_profile, diary, food_scan, recipes, progress
```

Reglas: los features no se importan entre sí; lo transversal vive en `core`.
La UI solo usa providers; los providers usan repositorios; los repositorios
usan el backend.

## Requisitos

- Flutter 3.47+ / Dart 3.13+
- Proyecto Supabase (migraciones en `supabase/migrations`)
- API key de Google AI Studio para el escaneo

## Configuración

Las claves publishable se pueden pasar por `--dart-define`:

```bash
flutter run \
  --dart-define SUPABASE_URL=https://<ref>.supabase.co \
  --dart-define SUPABASE_ANON_KEY=<anon-key> \
  --dart-define GEMINI_API_KEY=<gemini-key>
```

`GEMINI_KEY` funciona como alias de `GEMINI_API_KEY`. Si falta la key de IA,
la pantalla de escaneo lo indica y ofrece el registro manual.

### Backend

```bash
supabase db push --linked   # aplica supabase/migrations
```

## Comandos

```bash
dart run build_runner build -d   # genera .g.dart / .freezed.dart
flutter analyze
flutter test
```

## Estado

Fases 0-2 completadas (fundación, auth+perfil+diario, food scan con IA +
sincronización en tiempo real). Ver `docs/PROJECT_STATE.md`.
