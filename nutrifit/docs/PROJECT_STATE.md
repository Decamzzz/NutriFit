# Project State

Last updated: 2026-11-22

## Current phase
Fase 3 (parcial) — peso/IMC/objetivo, progreso con gráfica y recetario (con fotos) implementados; branding (logo) y áreas seguras listos. Falta: estadísticas de calorías/macros y racha.

## What works
- Sesión persistente: la app entra directo a /home si la sesión sigue viva; guard de rutas (públicas: onboarding/login, resto protegidas). Login determinista por resultado de la acción.
- Escaneo con IA: cámara/galería → Gemini (gemini-3.5-flash-lite) → resultados en línea → confirmación editable → diario (source=scan). Fallback manual y mensajes diferenciados (key faltante, sin comida, error).
- Sincronización en tiempo real: cambios en `diary_entries`/`profiles` (este u otro dispositivo) se reflejan sin cerrar sesión.
- Registro con confirmar contraseña y botón de ver/ocultar contraseña.
- Migración remota `20261012150000_fase2_realtime.sql` aplicada (publicación `supabase_realtime`).
- Registro con peso, estatura, objetivo e IMC en vivo; pantalla Progreso con gráfica de peso (fl_chart), meta, IMC e historial; Recetas (8, bilingües) con filtros, detalle y "Agregar al diario". Migración `20261117120000_fase3_body_weight.sql` (por aplicar).
- Branding y recetario visual: logo en onboarding/login (`core/widgets/app_logo.dart`) e imágenes de `lib/recipes_pictures/` en tarjetas y detalle (`RecipeImage`, con fallback al emoji).
- UI respeta las áreas seguras del sistema (edge-to-edge): los botones al final del scroll quedan por encima de la barra de navegación/gestos.
- `flutter analyze` limpio, `flutter test` 54 passed (+1 skipped), `flutter build web` OK.

## What is currently being implemented
- (nada en curso) Pulido de UI completado y verificado en local.

## Pending
- Fase 3: gráficas de calorías/macros semanales y racha (mockup screen5).
- Calcular `calorie_target` automáticamente (requiere edad y sexo).
- Fase 4: pulido, empty states, pulir escaneo (analizar varias fotos).

## Current important files
- `lib/features/progress/` (weight_summary, weight_chart_data, weight_providers, widgets), `lib/features/recipes/` (recipe_image incluido), `assets/recipes/recipes.json`, `lib/recipes_pictures/`, `lib/core/utils/body_metrics.dart`
- `lib/core/widgets/app_logo.dart`, `assets/images/logo.jpg`
- `supabase/migrations/20261117120000_fase3_body_weight.sql`
- `lib/features/food_scan/` (domain, data/gemini_food_scanner, data/food_estimate_parser, presentation/scan_page, presentation/widgets/scan_results, providers/scan_providers)
- `lib/features/diary/presentation/pages/confirm_scan_page.dart` (confirmación editable)
- `lib/core/services/realtime_service.dart`, `lib/core/providers/user_settings_provider.dart`
- `supabase/migrations/20261012150000_fase2_realtime.sql`

## Last completed work
- Logo, imágenes de recetas, áreas seguras del sistema y banner de depuración desactivado.

## Next recommended step
- Implementar `features/nutrition_stats` (promedios semanales y racha) y aplicar la migración de peso en remoto si aún no está.
