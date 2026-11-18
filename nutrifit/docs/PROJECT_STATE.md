# Project State

Last updated: 2026-11-17

## Current phase
Fase 3 (parcial) — peso/IMC/objetivo, progreso con gráfica y recetario implementados (pendiente verificar en local). Falta: estadísticas de calorías/macros y racha.

## What works
- Sesión persistente: la app entra directo a /home si la sesión sigue viva; guard de rutas (públicas: onboarding/login, resto protegidas). Login determinista por resultado de la acción.
- Escaneo con IA: cámara/galería → Gemini (gemini-3.5-flash-lite) → resultados en línea → confirmación editable → diario (source=scan). Fallback manual y mensajes diferenciados (key faltante, sin comida, error).
- Sincronización en tiempo real: cambios en `diary_entries`/`profiles` (este u otro dispositivo) se reflejan sin cerrar sesión.
- Registro con confirmar contraseña y botón de ver/ocultar contraseña.
- Migración remota `20261012150000_fase2_realtime.sql` aplicada (publicación `supabase_realtime`).
- Registro con peso, estatura, objetivo e IMC en vivo; pantalla Progreso con gráfica de peso (fl_chart), meta, IMC e historial; Recetas (8, bilingües) con filtros, detalle y "Agregar al diario". Migración `20261117120000_fase3_body_weight.sql` (por aplicar).
- (Fase 2) `flutter analyze` limpio, `flutter test` 29/29, `flutter build web` OK, escaneo real verificado con foto.

## What is currently being implemented
- Verificación local de Fase 3: build_runner, analyze, test, aplicar migración.

## Pending
- Fase 3: gráficas de calorías/macros semanales y racha (mockup screen5).
- Calcular `calorie_target` automáticamente (requiere edad y sexo).
- Fase 4: pulido, empty states, pulir escaneo (analizar varias fotos).

## Current important files
- `lib/features/progress/` (weight_summary, weight_chart_data, weight_providers, widgets), `lib/features/recipes/`, `assets/recipes/recipes.json`, `lib/core/utils/body_metrics.dart`
- `supabase/migrations/20261117120000_fase3_body_weight.sql`
- `lib/features/food_scan/` (domain, data/gemini_food_scanner, data/food_estimate_parser, presentation/scan_page, presentation/widgets/scan_results, providers/scan_providers)
- `lib/features/diary/presentation/pages/confirm_scan_page.dart` (confirmación editable)
- `lib/core/services/realtime_service.dart`, `lib/core/providers/user_settings_provider.dart`
- `supabase/migrations/20261012150000_fase2_realtime.sql`

## Last completed work
- Peso/IMC/objetivo en registro, progreso de peso con gráfica y recetario.

## Next recommended step
- Verificar Fase 3 en local y luego `features/nutrition_stats` (promedios semanales y racha).
