# NutriFit

App móvil de seguimiento nutricional. Permite registrar comidas, escanear platillos con IA, seguir
calorías y macros diarios, consultar un recetario bilingüe y visualizar la evolución
del peso con metas e IMC.

---

## Características

### Autenticación y perfil
- Registro e inicio de sesión con Supabase (email + contraseña).
- Registro con confirmación de contraseña y botón para mostrar/ocultar.
- Datos corporales en el alta: peso, estatura, objetivo (perder/mantener/ganar)
  y peso meta, con IMC calculado en vivo.
- Sesión persistente: si la sesión sigue viva, la app abre directo en `/home`.
- Perfil editable (objetivo, estatura, peso meta).

### Diario de comidas
- Vista por día con anillo de calorías, barras de macros y tarjetas por comida
  (desayuno, almuerzo, cena, snack).

### Escaneo de comida con IA
- Cámara o galería con `image_picker`.
- Estimación nutricional con Gemini (`gemini-3.5-flash-lite`, salida JSON,
  temperatura 0.2) a partir de la foto.
- Resultados editables antes de guardar; se registran en el diario con
  `source = 'scan'`.
- La foto **nunca se sube ni se guarda**: solo viaja a Gemini y se descarta.
- Fallback manual y mensajes diferenciados (falta la API key, no se detectó
  comida, error de red/servicio).

### Recetario
- 8 recetas bilingües (ES/EN) definidas en `assets/recipes/recipes.json`.
- Filtros por categoría, tarjetas con foto real y detalle con ingredientes,
  pasos y macros.
- Botón “Agregar al diario” que reutiliza la confirmación editable del escaneo
  (`source = 'recipe'`).
- Imágenes locales en `lib/recipes_pictures/`.

### Progreso
- Gráfica de peso con `fl_chart`, meta visual y rango ajustado a los datos.
- Tarjetas de peso actual, IMC, progreso hacia la meta e historial.
- Registro de peso por día (un valor por usuario y fecha) con upsert.
- Cálculo de IMC y utilidades corporales en `core/utils/body_metrics.dart`.

### Preferencias y UX
- i18n manual ES/EN (`lib/core/l10n/app_strings.dart`), sin textos hardcodeados.
- Tema claro/oscuro/sistema, persistido con `shared_preferences`.
- Interfaz respetuosa con edge-to-edge: los CTAs al final del scroll quedan
  sobre la barra de navegación/gestos del sistema.

---

## Stack tecnológico

| Capa | Tecnología |
| --- | --- |
| Framework | Flutter 3.47.5 (stable) · Dart SDK `^3.13.4` |
| Estado | Riverpod 3 (`flutter_riverpod ^3.4.3`, `riverpod_generator ^4.0.9`) |
| Navegación | `go_router ^18.0.2` (StatefulShellRoute con 4 tabs) |
| Modelos | `freezed ^4.0.2` + `json_serializable ^6.14.1` |
| Backend | Supabase (`supabase_flutter ^2.9.0`): Auth, Postgres, Realtime |
| IA | `google_generative_ai ^0.4.7` (Gemini 3.5 Flash Lite, visión) |
| Gráficas | `fl_chart ^1.1.0` |
| Dispositivo | `image_picker ^1.1.2`, `shared_preferences ^2.5.3` |
| i18n | `intl ^0.20.2` + tablas manuales ES/EN |

---

## Arquitectura

Organización **feature-first** con tres capas por feature:

```
UI (widgets/pages)
   ↓ solo lee providers
Providers (Riverpod)
   ↓
Repositorios (domain: interfaces · data: implementaciones)
   ↓
Supabase · Gemini · assets locales
```

Reglas del proyecto:

- Los features **no se importan entre sí**; lo transversal vive en `core/`.
- La UI no accede a fuentes de datos: solo a providers.
- Modelos inmutables con `freezed`; se evita `dynamic`.
- Todo texto visible pasa por i18n (ES/EN).
- Estados asíncronos con `AsyncValue` (loading y error siempre manejados).
- Widgets pequeños (< ~150 líneas).
- Archivos en `snake_case`, un widget público por archivo.
- El DTO `core/models/nutrition_item.dart` es el contrato que cruza features
  (escaneo → confirmación → diario) sin acoplarlas.

### Estructura

```
lib/
├── main.dart                 # bootstrap + SupabaseService.init()
├── app/                      # router, shell de tabs, tema, settings
│   ├── app.dart
│   ├── router.dart
│   ├── scaffold_with_nav_bar.dart
│   ├── providers/            # tema, locale, strings
│   └── theme/
├── core/                     # transversal (no depende de features)
│   ├── constants/            # límites y valores por defecto
│   ├── data/                 # implementación del port de perfil
│   ├── errors/               # Failure
│   ├── l10n/                 # AppStrings ES/EN
│   ├── models/               # UserSettings, NutritionItem
│   ├── ports/                # UserSettingsPort
│   ├── providers/            # sesión, perfil, sync realtime
│   ├── services/             # Supabase, Gemini, Realtime, AppConfig
│   ├── utils/                # body_metrics, nutrition_calc, date_utils
│   └── widgets/              # AppButton, AppCard, AppLogo, loader, error
├── features/
│   ├── auth_profile/         # onboarding, login, perfil
│   ├── diary/                # home, add food, confirm scan, totales
│   ├── food_scan/            # cámara → Gemini → resultados
│   ├── progress/             # peso, IMC, meta, gráfica
│   └── recipes/              # catálogo, detalle, filtros
└── recipes_pictures/         # fotos locales del recetario

assets/
├── images/logo.jpg
└── recipes/recipes.json

supabase/migrations/          # SQL versionado (Fases 1-3)
test/                         # unit + widget tests
docs/                         # PROJECT_STATE, CHANGELOG_AI, DECISIONS
src/                          # mockups de diseño (screen1-6.png)
```

---

## Rutas

| Ruta | Pantalla | Acceso |
| --- | --- | --- |
| `/onboarding` | Bienvenida | Pública |
| `/login` | Login / registro | Pública |
| `/home` | Diario del día (tab) | Privada |
| `/recipes` | Recetario (tab) | Privada |
| `/recipe/:id` | Detalle de receta | Privada |
| `/progress` | Progreso (tab) | Privada |
| `/profile` | Perfil (tab) | Privada |
| `/add-food/:meal` | Alta manual de alimento | Privada |
| `/scan` | Escaneo con IA | Privada |
| `/scan/confirm` | Confirmación editable (`?source=recipe`) | Privada |

---

## Modelo de datos (Supabase)

Migraciones en `supabase/migrations/`:

- `20261012135338_fase1_profiles_diary.sql`
- `20261012150000_fase2_realtime.sql`
- `20261117120000_fase3_body_weight.sql`

| Tabla | Contenido |
| --- | --- |
| `profiles` | 1:1 con `auth.users`: nombre, email, objetivo, nivel de actividad, `calorie_target`, `height_cm`, `goal_weight_kg`. |
| `diary_entries` | Una fila por alimento: fecha, comida, nombre, gramos, kcal, proteína, carbos, grasa, `source` (`manual`/`scan`/`recipe`). |
| `weight_logs` | Un peso por usuario y día (`unique(user_id, date)`), usado por la gráfica. |

- **RLS activado** en las tres tablas: cada usuario solo lee/escribe sus filas
  (`auth.uid()`).
- **Trigger `handle_new_user`**: crea el perfil al registrarse y, si el alta
  incluye datos corporales, guarda `height_cm`, `goal_weight_kg` y el primer
  `weight_log`. Se hace en el servidor porque `signUp` puede no devolver sesión
  cuando la confirmación por correo está activa.
- **Realtime**: `diary_entries`, `profiles` y `weight_logs` están en la
  publicación `supabase_realtime`; la app invalida cachés al recibir cambios.

---

## Requisitos

- Flutter 3.47+ (stable) y Dart 3.13+.
- Proyecto Supabase con las migraciones aplicadas.
- API key de Google AI Studio (Gemini) para el escaneo.
- (Opcional) Supabase CLI para aplicar migraciones.

## Configuración y ejecución

```bash
git clone https://github.com/Decamzzz/NutriFit.git
cd NutriFit/nutrifit
flutter pub get
```

### Claves

La app lee las claves en tiempo de compilación con `String.fromEnvironment`
(`lib/core/services/app_config.dart`), **no** desde `.env`. El archivo
`.env.example` solo documenta las variables:

```bash
flutter run \
  --dart-define SUPABASE_URL=https://<ref>.supabase.co \
  --dart-define SUPABASE_ANON_KEY=<anon-key> \
  --dart-define GEMINI_API_KEY=<gemini-key>
```

- `GEMINI_KEY` es un alias de `GEMINI_API_KEY` (tiene prioridad).
- Si faltan las claves de Supabase la app corre en modo degradado (útil para
  UI y tests).
- Sin key de Gemini, el escaneo lo indica y ofrece el registro manual.

### Backend

```bash
supabase link --project-ref <ref>
supabase db push --linked        # aplica supabase/migrations
```

### Ejecutar

```bash
flutter run                      # dispositivo/emulador
flutter run -d chrome            # web
flutter build web --release      # build web
```

Iconos de la app (usa el logo):

```bash
dart run flutter_launcher_icons
```

---

## Generación de código y calidad

```bash
dart run build_runner build -d     # .g.dart / .freezed.dart
dart run build_runner watch -d     # modo watch
flutter analyze                    # debe quedar sin issues
flutter test                       # unit + widget tests
```

Estado actual: `flutter analyze` limpio, `flutter test` **54 pasan + 1 omitido**
(probe manual de Gemini), `flutter build web --release` OK.

### Tests

- `test/core/` — utilidades (fechas, nutrición, IMC), modelos e i18n.
- `test/app/` — sesión y guard de rutas.
- `test/features/` — parser de Gemini, controlador de escaneo, lógica del
  diario, recetas (catálogo e imágenes), progreso y login.
- `test/manual_gemini_probe_test.dart` — llamada real a Gemini, omitida por
  defecto:

```powershell
$env:GEMINI_PROBE='1'
flutter test test/manual_gemini_probe_test.dart --dart-define=GEMINI_API_KEY=<key>
```

---

## i18n y temas

- Todos los textos viven en `lib/core/l10n/app_strings.dart` con tablas ES/EN
  (`stringsProvider`). Agregar un texto = añadir la clave en ambas tablas.
- El idioma y el tema se guardan con `shared_preferences` y se aplican al
  arrancar (`MaterialApp.router` con `locale` y `themeMode`).

## Documentación del proyecto

| Archivo | Contenido |
| --- | --- |
| [`docs/PROJECT_STATE.md`](docs/PROJECT_STATE.md) | Estado actual, pendientes y archivos clave. |
| [`docs/CHANGELOG_AI.md`](docs/CHANGELOG_AI.md) | Historial de cambios por fecha. |
| [`docs/DECISIONS.md`](docs/DECISIONS.md) | ADRs (decisiones de arquitectura). |
| [`AGENTS.md`](AGENTS.md) | Convenciones y comandos del proyecto. |

## Fuera de alcance

Pagos, funciones sociales, notificaciones push, escaneo de códigos de barras y
wearables.

---

© Deiby Camilo Botina - Jaider España - 2026
