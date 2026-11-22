# AI Development Log

## 2026-11-22 — Log: Sin banner de depuración en las interfaces

### Request
Quitar el banner que Flutter dibuja sobre las pantallas.

### Changes
- `MaterialApp.router` ahora usa `debugShowCheckedModeBanner: false`, así que la cinta "DEBUG" (o "PROFILE") deja de aparecer en la esquina superior derecha de todas las pantallas.

### Files
Modified:
- lib/app/app.dart

### Verification
- `flutter analyze`: No issues found.
- `flutter test`: 54 passed, 1 skipped.

---

## 2026-11-20 — Log: Logo, imágenes de recetas y áreas seguras del sistema

### Request
Poner el logo `logo.jpg` en la app; usar las imágenes de `lib/recipes_pictures/` en el recetario; y corregir que los botones al final del scroll (receta, resultados del escaneo y guardado en el diario) quedaran debajo de la barra de acciones del teléfono.

### Changes
- **Logo**: `logo.jpg` se copió a `assets/images/logo.jpg` y se creó `core/widgets/app_logo.dart` (`AppLogo`). Se muestra en onboarding (con layout desplazable para pantallas pequeñas) y en login. Al ser un widget de `core`, cualquier feature puede reutilizarlo.
- **Recetas con foto**: se agregó `Recipe.image` (asset key) y el campo `image` a las 8 recetas de `assets/recipes/recipes.json`. Las imágenes de `lib/recipes_pictures/` se declararon en `pubspec.yaml` y se creó `RecipeImage`, que usa `Image.asset` con `BoxFit.cover` y cae al emoji de la receta si el asset falta. La tarjeta y el detalle ahora muestran la foto real.
- **Áreas seguras (edge-to-edge)**: las pantallas con contenido o acciones al final del scroll envuelven el body en `SafeArea(top: false)`: detalle de receta, resultados del escaneo, confirmación del escaneo, agregar comida y login. Así el botón de "Agregar al diario"/"Guardar" queda por encima de la barra de navegación o del área de gestos de Android.
- **Limpieza de lints**: se aplicó el marcador null-aware (`?`) en dos mapas/listas para dejar `flutter analyze` sin avisos.
- Tests: el catálogo ahora valida que cada receta tenga imagen y que el archivo exista; el test de onboarding busca el título i18n (la marca pasó a ser parte del logo).

### Files
Added:
- assets/images/logo.jpg
- lib/core/widgets/app_logo.dart
- lib/features/recipes/presentation/widgets/recipe_image.dart

Modified:
- assets/recipes/recipes.json (campo `image` en las 8 recetas)
- pubspec.yaml (asset `lib/recipes_pictures/`)
- lib/features/recipes/domain/recipe.dart
- lib/features/recipes/presentation/widgets/recipe_card.dart
- lib/features/recipes/presentation/pages/recipe_detail_page.dart
- lib/features/auth_profile/presentation/pages/onboarding_page.dart
- lib/features/auth_profile/presentation/pages/login_page.dart
- lib/features/food_scan/presentation/pages/scan_page.dart
- lib/features/diary/presentation/pages/confirm_scan_page.dart
- lib/features/diary/presentation/pages/add_food_page.dart
- lib/core/data/user_settings_port_impl.dart, lib/features/progress/domain/weight_chart_data.dart (lints)
- test/widget_test.dart, test/features/recipes/domain/recipe_test.dart, test/features/recipes/presentation/recipes_page_test.dart

### Verification
- `dart run build_runner build -d`: OK.
- `flutter analyze`: No issues found.
- `flutter test`: 54 passed, 1 skipped (probe manual de Gemini).
- `flutter build web --release`: OK; el manifest incluye `assets/images/logo.jpg` y `lib/recipes_pictures/*`.

---

## 2026-11-17 — Log: Peso/IMC/objetivo en el registro, gráfica de progreso y recetario

### Request
Al crear el usuario pedir peso (y calcular el IMC) y un objetivo; poder registrar nuevos pesos y ver una gráfica de la evolución; terminar las recetas con 5-6 sugerencias con sus calorías.

### Changes
- **Registro**: nuevos campos peso, estatura, objetivo (perder/mantener/ganar) y peso meta (solo si no es mantener), con vista previa del IMC mientras se escribe. Valida rangos y que la meta vaya en la dirección del objetivo. Acepta decimales con coma.
- Los datos viajan en `raw_user_meta_data` del `signUp` y los guarda el trigger `handle_new_user` (perfil + primer `weight_logs`), porque con confirmación de correo el signUp no devuelve sesión y RLS impediría escribir desde el cliente. El cliente manda `weight_date` (día local) porque `current_date` del servidor es UTC.
- **Progreso**: tabla `weight_logs` (un peso por usuario y día, upsert), pantalla con peso actual, cambio en 7 días, gráfica `fl_chart` con línea punteada de meta, progreso hacia la meta, tarjeta de IMC con escala, historial con borrado y bottom sheet para registrar peso (con selector de fecha). Sync Realtime.
- **Perfil**: tarjeta "Datos corporales" para editar estatura y peso objetivo (también cubre a usuarios previos, que tienen esos campos en null).
- **Recetas**: `assets/recipes/recipes.json` con 8 recetas bilingües (2 por categoría; kcal calculadas desde ingredientes), lista con filtros (Todas/Desayuno/Almuerzo/Cena/Snacks), detalle con macros, ingredientes y pasos, y botón "Agregar al diario" que reutiliza `/scan/confirm?source=recipe` (`diary_entries.source = 'recipe'`).
- Lógica pura y testeable: `core/utils/body_metrics.dart`, `BmiCategory`, `WeightSummary`, `WeightChartData`.
- Fix menor: typo "belongs" en `selectMeal` (ES).

### Files
Added:
- supabase/migrations/20261117120000_fase3_body_weight.sql
- assets/recipes/recipes.json
- lib/core/utils/body_metrics.dart
- lib/features/progress/{domain,data,presentation/providers,presentation/widgets}/ (weight_log, weight_repository, weight_summary, weight_chart_data, weight_repository_impl, weight_providers, weight_chart, weight_card, goal_progress_card, bmi_card, weight_history_card, log_weight_sheet)
- lib/features/recipes/{domain,data,presentation}/ (recipe, localized_text, recipe_category, recipe_repository, asset_recipe_repository, recipe_providers, recipe_labels, category_chips, recipe_card, macro_tile, recipe_detail_page)
- lib/features/auth_profile/domain/body_profile_input.dart, presentation/widgets/{register_body_fields,body_data_card,number_input_dialog}.dart
- Tests: body_metrics, weight_summary (+ chart data), recipe (catálogo), recipes_page, login_page (registro), app_strings, user_settings, date_utils, nutrition_calc

Modified:
- lib/core/models/user_settings.dart (heightCm, goalWeightKg), ports/data/providers de user settings (`saveBodyData`)
- lib/core/utils/{date_utils,nutrition_calc}.dart, lib/core/l10n/app_strings.dart
- lib/features/auth_profile (auth repository/controller con `BodyProfileInput`, login_page, profile_page)
- lib/features/progress/presentation/pages/progress_page.dart, lib/features/recipes/presentation/pages/recipes_page.dart
- lib/features/diary/presentation/pages/confirm_scan_page.dart (parámetro `source`)
- lib/app/router.dart (`/recipe/:id`, `source`), lib/app/app.dart (weight realtime)

### Verification
Pendiente de ejecutar en local (el entorno donde se escribió no tenía Flutter): `dart run build_runner build -d`, `flutter analyze`, `flutter test`, y aplicar la migración (`supabase db push`).

## 2026-10-12 — Log: Fix login que solo funcionaba tras instalar

### Request
El login funcionaba la primera vez tras instalar; al cerrar y reabrir la app ya no entraba (Supabase respondía 200). Borrar los datos de la app lo arreglaba, y el ciclo se repetía.

### Changes
- Causa raíz: `onAuthStateChange` de gotrue es un `ReplaySubject`, así que al reabrir la app la sesión persistida se entrega **antes** de que se monte la pantalla de login. La navegación dependía de un *cambio* del stream de sesión: como el id no cambia (mismo usuario), el listener nunca disparaba y la app se quedaba en /login aunque el login respondiera 200. Borrar los datos eliminaba la sesión persistida, el id sí cambiaba y por eso "funcionaba".
- `AuthController.signIn/signUp` ahora devuelven `bool` (éxito real de la operación) y `LoginPage` navega a `/home` **según el resultado de la acción**, no según un evento del stream.
- Router: pasa a ser un provider (`appRouterProvider`) con `redirect` de sesión. Rutas públicas `/onboarding` y `/login`; el resto exige sesión. Con sesión restaurada la app entra directo a `/home`; sin sesión, las rutas privadas redirigen a `/login`.
- `SessionUserId` deja de ser un StreamProvider auto-dispose y pasa a ser un Notifier con `keepAlive()` y suscripción propia: el valor es estable, no se re-suscribe en cada navegación y el guard siempre ve el mismo estado. El origen del stream (`authUserIdStreamProvider`) es un `Provider` plano, sustituible en tests.
- Bypass de auto-dispose: se eliminó `sessionUserIdNow` y `currentUserId` (código muerto).
- Tests: regresión del login (sesión ya presente, el id no cambia → aun así navega), guard de rutas (`sessionRedirect` puro), y arranque de app con/sin sesión.

### Files
Added:
- test/app/router_test.dart
- test/app/app_session_test.dart
- test/features/auth_profile/presentation/login_page_test.dart

Modified:
- lib/app/router.dart (provider + guard `sessionRedirect`)
- lib/app/app.dart (usa `appRouterProvider`)
- lib/core/providers/session_provider.dart (Notifier con keepAlive)
- lib/core/providers/user_settings_provider.dart, lib/features/diary/presentation/providers/diary_providers.dart (consumo del nuevo tipo)
- lib/features/auth_profile/presentation/providers/auth_providers.dart
- lib/features/auth_profile/presentation/pages/login_page.dart (navegación por resultado)

### Verification
- `flutter analyze`: No issues found.
- `flutter test`: 29/29 passed (1 skipped: probe manual).
- `flutter build web --release`: OK.

### Notes
- Con este fix la sesión persiste entre reinicios: la app abre directamente en /home y el login solo aparece tras cerrar sesión.

---

## 2026-10-12 — Log: Fix escaneo sin resultado visible

### Request
El escaneo realizaba la petición a Gemini (visible en AI Studio) pero en la app no aparecía ningún resultado.

### Changes
- Causa raíz: el listener de `scanControllerProvider` se ejecutaba **antes** de guardar las estimaciones (Riverpod notifica de forma síncrona al asignar `state`), por lo que leía una lista vacía y nunca navegaba; además la pantalla no renderizaba los resultados, solo esperaba la navegación.
- `ScanController`: el estado pasa a ser `AsyncValue<List<FoodEstimate>>` (las estimaciones viajan en el estado); se eliminó `scanEstimatesProvider` (estado duplicado).
- `ScanPage`: renderiza el resultado en línea (nuevo widget `ScanResults` con alimentos detectados y botón "Agregar al diario"); la navegación a `/scan/confirm` ahora es explícita y determinista; se eliminó el `ref.listen` frágil.
- `ConfirmScanPage`: estado vacío con mensaje y botón para ir al escáner.
- Manejo de errores más fino: `no-gemini-key` → falta la key; `empty-result` → "no se detectó comida"; selección de imagen con error de lectura y bytes vacíos.
- `debugPrint` de la respuesta cruda de Gemini en debug para diagnóstico.
- Tests: regresión del listener (las estimaciones ya están disponibles cuando cambia el estado) y widget test de `ScanResults`. Nueva prueba manual `test/manual_gemini_probe_test.dart` (activada con `GEMINI_PROBE=1`) que ejecuta el escaneo real.

### Files
Added:
- lib/features/food_scan/presentation/widgets/scan_results.dart
- test/features/food_scan/presentation/scan_results_test.dart
- test/manual_gemini_probe_test.dart

Modified:
- lib/features/food_scan/presentation/providers/scan_providers.dart
- lib/features/food_scan/presentation/pages/scan_page.dart
- lib/features/food_scan/data/gemini_food_scanner.dart (log en debug)
- lib/features/diary/presentation/pages/confirm_scan_page.dart
- lib/core/l10n/app_strings.dart (detectedFoods, addToDiary, emptyScan, noFoodDetected)

### Verification
- `flutter analyze`: No issues found.
- `flutter test`: 24/24 passed (1 skipped: probe manual).
- Prueba real con `src/screen1.png` (foto de comida): 7 alimentos detectados con kcal y macros correctos.
- Prueba real con `src/screen2.png` (mockup, no es comida): el modelo devuelve `[]` → mensaje "no se detectó comida" + fallback manual.

### Notes
- El NPE de `deliverResultsIfNeeded` en el log de Android es ruido del sistema al devolver el resultado del intent de la cámara; no afecta la selección de la imagen (además ahora se capturan los fallos de lectura).

---

## 2026-10-12 — Log: Fase 2 food scan + Realtime + login con confirmar contraseña

### Request
Fase 2 (food scan con Gemini: pick → preview → scan → confirmar → diario, sin Storage, con manejo de errores), sincronización automática con Supabase (los cambios no se veían en la UI sin cerrar sesión) y registro con doble campo de contraseña y opción de visualizarla.

### Changes
- Backend: migración `20261012150000_fase2_realtime.sql` (publica `diary_entries` y `profiles` en `supabase_realtime`), aplicada y verificada con query.
- Realtime: `core/services/realtime_service.dart` (suscripción `postgres_changes` filtrada por usuario), `watchChanges()` en `DiaryRepository`/`UserSettingsPort`, providers `diaryRealtimeSyncProvider` y `userSettingsRealtimeSyncProvider` (watch en `app.dart`) que invalidan las cachés.
- Fix de refresco: `userSettings` ya no lee `.future` de un StreamProvider (quedaba colgado al invalidar); ahora usa el valor del stream.
- Refactor: perfil movido a `core` (models/ports/data/providers `UserSettings`) para eliminar el import `diary -> auth_profile`; `auth_profile` conserva auth + páginas. Eliminado `UserProfile`/`ProfileRepository` duplicados.
- food_scan: `domain/food_estimate.dart` (freezed), `domain/food_scan_repository.dart`, `domain/food_estimate_mapper.dart`, `data/food_estimate_parser.dart` (parser puro tolerante), `data/gemini_food_scanner.dart` (Gemini `gemini-3.5-flash-lite`, JSON estricto, temperatura 0.2), `presentation/pages/scan_page.dart` (cámara/galería + preview + análisis + fallback manual), `presentation/providers/scan_providers.dart` (controller AsyncValue + estimates).
- Confirmación editable: `features/diary/presentation/pages/confirm_scan_page.dart` (recibe `List<NutritionItem>` por `extra`, elige comida, corrige valores, guarda con `source='scan'`).
- Router: rutas `/scan` y `/scan/confirm`; accesos desde home (FAB) y add-food.
- Login: campo de confirmación de contraseña (solo registro) + toggle ver/ocultar en ambos campos, con validación (mínimo 6, coinciden, email válido).
- Config: `AppConfig.effectiveGeminiKey` acepta `GEMINI_KEY` como alias de `GEMINI_API_KEY`; mensaje i18n cuando falta la key. Permisos iOS (NSCamera/NSPhotoLibrary) y Android (INTERNET + queries IMAGE_CAPTURE).
- i18n: 20 claves nuevas ES/EN. README y `.env.example` actualizados.

### Files
Added:
- supabase/migrations/20261012150000_fase2_realtime.sql
- lib/core/services/realtime_service.dart
- lib/core/models/user_settings.dart (+.freezed/+g), lib/core/models/nutrition_item.dart
- lib/core/ports/user_settings_port.dart, lib/core/data/user_settings_port_impl.dart
- lib/core/providers/user_settings_provider.dart (+.g.dart), lib/core/providers/session_provider.dart (+.g.dart)
- lib/features/food_scan/domain/food_estimate.dart (+.freezed/+g), food_scan_repository.dart, food_estimate_mapper.dart
- lib/features/food_scan/data/food_estimate_parser.dart, gemini_food_scanner.dart
- lib/features/food_scan/presentation/pages/scan_page.dart
- lib/features/food_scan/presentation/providers/scan_providers.dart (+.g.dart)
- lib/features/diary/presentation/pages/confirm_scan_page.dart
- test/features/food_scan/data/food_estimate_parser_test.dart
- test/features/food_scan/presentation/scan_controller_test.dart
- test/core/models/user_settings_test.dart (movido desde features/auth_profile)

Modified:
- lib/features/auth_profile/presentation/pages/login_page.dart, profile_page.dart
- lib/features/auth_profile/presentation/providers/auth_providers.dart
- lib/features/diary/presentation/pages/home_page.dart, add_food_page.dart
- lib/features/diary/domain/diary_repository.dart, data/diary_repository_impl.dart
- lib/app/app.dart, lib/app/router.dart, lib/core/l10n/app_strings.dart
- lib/core/services/app_config.dart, gemini_service.dart, supabase_service.dart
- ios/Runner/Info.plist, android/app/src/main/AndroidManifest.xml
- README.md, .env.example, docs/*

Deleted:
- lib/features/auth_profile/domain/user_profile.dart, profile_repository.dart
- lib/features/auth_profile/data/profile_repository_impl.dart

### Verification
- `supabase db push --linked` + query: `diary_entries` y `profiles` en `supabase_realtime`.
- Prueba real contra Gemini API con `src/screen2.png`: HTTP 200 y array JSON con el formato esperado (validado con el parser).
- `dart run build_runner build -d`: Built OK.
- `flutter analyze`: No issues found.
- `flutter test`: 22/22 passed.
- `flutter build web --release`: OK.

### Notes
- La key de Gemini quedó solo como `--dart-define` (el usuario la quitó de `app_config.dart`); sin ella el escaneo muestra aviso y ofrece registro manual.
- La foto no se persiste (sin Storage por decisión de alcance).

---

## 2026-10-12 — Log: Fase 1 Auth+Perfil+Diario

### Request
Continuar con Fase 1 usando proyecto Supabase existente y CLI vinculada.

### Changes
- Keys: revertido `app_constants.dart` a nombres de define; valores publishable como `defaultValue` en `AppConfig` (override con --dart-define); `.secret` añadido a `.gitignore`.
- Backend: migración `20261012135338_fase1_profiles_diary.sql` (profiles, diary_entries, índices, trigger handle_new_user, RLS por usuario) aplicada en remoto; tablas verificadas con query.
- auth_profile: `UserProfile` (freezed+json snake_case), `AuthRepository`/`ProfileRepository` + impls Supabase, providers (authUserId stream, profile, AuthController, ProfileEditor), login/registro real con navegación a /home, perfil con editor de metas + ajustes tema/idioma + sign out.
- diary: `MealType`, `DiaryEntry` (freezed+json), `MacroTotals`, `DiaryRepository` + impl Supabase, providers (DiaryDay, dayEntries, dayTotals, DiaryEditor), seed `kFrequentFoods`, widgets `CalorieRing/MacroBar/MealCard`, home real (screen2) y add-food (screen3, frecuentes + manual + tip).
- Router: ruta `/add-food/:meal`; onboarding CTA ahora va a /login.
- i18n: ~45 claves nuevas ES/EN (auth, metas, diario).
- Tests: `user_profile_test` (snake_case+defaults), `diary_logic_test` (parse, totales, filtro, defaults). Total 11/11.
- Fix: imports relativos en providers nuevos (un nivel faltante rompía el generator) y `fromJson` a `Map<String, dynamic>`; regla de tipos puros en firmas (ADR-006).

### Files
Added:
- supabase/migrations/20261012135338_fase1_profiles_diary.sql
- lib/features/auth_profile/domain/user_profile.dart (+.freezed/+g), auth_repository.dart, profile_repository.dart
- lib/features/auth_profile/data/auth_repository_impl.dart, profile_repository_impl.dart
- lib/features/auth_profile/presentation/providers/auth_providers.dart (+.g.dart)
- lib/features/diary/domain/meal_type.dart, diary_entry.dart (+.freezed/+g), macro_totals.dart, diary_repository.dart
- lib/features/diary/data/diary_repository_impl.dart, frequent_foods.dart
- lib/features/diary/presentation/providers/diary_providers.dart (+.g.dart)
- lib/features/diary/presentation/widgets/calorie_ring.dart, macro_bar.dart, meal_card.dart
- lib/features/diary/presentation/pages/add_food_page.dart
- test/features/auth_profile/domain/user_profile_test.dart
- test/features/diary/domain/diary_logic_test.dart

Modified:
- lib/core/constants/app_constants.dart, lib/core/services/app_config.dart, .gitignore
- lib/core/l10n/app_strings.dart, lib/app/router.dart
- lib/features/auth_profile/presentation/pages/onboarding_page.dart, login_page.dart, profile_page.dart
- lib/features/diary/presentation/pages/home_page.dart
- docs/PROJECT_STATE.md, docs/DECISIONS.md, docs/CHANGELOG_AI.md

### Verification
- `supabase db push --linked`: migración aplicada; query confirma profiles + diary_entries.
- `dart run build_runner build -d`: Built, outputs OK.
- `flutter analyze`: No issues found.
- `flutter test`: 11/11 passed.

### Notes
- `anonKey` del SDK sigue marcado deprecated (ignore local hasta migrar a publishableKey).
- Sin guard de rutas: usuario sin sesión ve CTA a /login en tabs (guard real en Fase 4 si hay tiempo).

---

## 2026-10-09 — Log: Fase 0 fundación

### Request
Iniciar Fase 0: fundación escalable (router, tema, i18n, Supabase) según plan aprobado.

### Changes
- Pubspec a stack moderno compatible Dart 3.13 (Riverpod 3.4, go_router 18, freezed 4, supabase_flutter 2.9, fl_chart 1.1, google_generative_ai, image_picker, shared_preferences).
- Creados `app/app.dart`, `app/router.dart` (StatefulShellRoute 4 tabs), `app/scaffold_with_nav_bar.dart`, `app/theme/*`, `app/providers/app_settings.dart` (ThemeMode+Locale persistidos + strings provider, con .g.dart generado).
- Creados `core/constants`, `core/errors/failure.dart` (freezed), `core/utils/nutrition_calc.dart` (BMI/Mifflin/TDEE/target) + `date_utils.dart`, `core/widgets` (button/card/loader/error), `core/services` (AppConfig dart-define, SupabaseService degradado, GeminiService factory), `core/l10n/app_strings.dart` (ES/EN).
- Placeholders de navegación: onboarding, login, home, recipes, progress, profile.
- `main.dart` con ProviderScope + init Supabase; `.env.example`, `.gitignore` ignora `.env`, carpetas `assets/recipes`, `assets/images`.
- Tests: reemplazo del counter demo por smoke de app + unit de nutrition_calc, date_utils, app_strings.

### Files
Added:
- lib/app/app.dart, lib/app/router.dart, lib/app/scaffold_with_nav_bar.dart
- lib/app/theme/app_colors.dart, lib/app/theme/app_typography.dart, lib/app/theme/app_theme.dart
- lib/app/providers/app_settings.dart (+ .g.dart)
- lib/core/constants/app_constants.dart, lib/core/errors/failure.dart (+ .freezed.dart)
- lib/core/utils/nutrition_calc.dart, lib/core/utils/date_utils.dart
- lib/core/widgets/app_button.dart, app_card.dart, app_loader.dart, app_error_view.dart
- lib/core/services/app_config.dart, supabase_service.dart, gemini_service.dart
- lib/core/l10n/app_strings.dart
- lib/features/auth_profile/presentation/pages/onboarding_page.dart, login_page.dart, profile_page.dart
- lib/features/diary/presentation/pages/home_page.dart
- lib/features/recipes/presentation/pages/recipes_page.dart
- lib/features/progress/presentation/pages/progress_page.dart
- test/core/utils/nutrition_calc_test.dart, test/core/utils/date_utils_test.dart, test/core/l10n/app_strings_test.dart
- .env.example, assets/recipes/, assets/images/

Modified:
- lib/main.dart, pubspec.yaml, .gitignore, test/widget_test.dart
- docs/PROJECT_STATE.md, docs/DECISIONS.md, docs/CHANGELOG_AI.md

### Verification
- `dart run build_runner build -d`: 3 outputs, OK.
- `flutter analyze`: No issues found.
- `flutter test`: 5/5 passed.

### Notes
- Se subió el stack a versiones mayores por incompatibilidad analyzer/Dart 3.13 (riverpod_generator 2.x + freezed 3.1 no compilaban). Decisión registrada en ADR-001.
- Supabase `anonKey` marcado deprecated por el SDK; se mantiene con ignore hasta migrar a publishableKey.

---
