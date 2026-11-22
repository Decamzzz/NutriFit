# Architecture Decision Records

## ADR-001 — Decision: Riverpod generator + go_router + freezed + fl_chart + Supabase

Date: 2026-10-09

### Decision
Stack oficial: flutter_riverpod 3 + riverpod_generator 4, go_router 18 con StatefulShellRoute, freezed 4 para modelos, fl_chart para gráficas, supabase_flutter para Auth+DB.

### Context
Proyecto universitario Fitia-like que debe escalar por features sin lógica en widgets.

### Consequences
Requiere `dart run build_runner build -d` tras cambiar providers/modelos. Curva inicial mayor, pero contratos estables entre fases.

### Alternatives considered
Bloc, Provider manual, charts custom.

### Reason
Alineado con AGENTS.md y permite test unitario de utils sin Flutter.

---

## ADR-002 — Decision: Estimación nutricional con Google AI Studio (Gemini 3.5 Flash Lite)

Date: 2026-10-09

### Decision
Usar `google_generative_ai` modelo `gemini-2.0-flash` con API Key por `--dart-define GEMINI_API_KEY`, resultado JSON editable antes de guardar en diario.

### Context
El usuario ya tiene API Key probada con lotes de imágenes; suficiente para alcance académico.

### Consequences
Sin costo de Storage (no se suben fotos, solo el estimado). Requiere manejo de JSON inválido + fallback manual.

### Alternatives considered
OpenAI Vision (pago), mock local puro.

### Reason
Cuota generosa, fácil integración, key ya validada.

---

## ADR-003 — Decision: Supabase solo Auth+DB, sin Storage en v1

Date: 2026-10-09

### Decision
Supabase para autenticación y tablas (`profiles`, `diary_entries`, luego `weight_logs`); fotos no se persisten. Init degradado si faltan keys para demo/tests.

### Context
Decisión del usuario para simplificar entrega universitaria.

### Alternatives considered
Auth+DB+Storage, mock local primero.

### Reason
Menos RLS/bucket que configurar; migración a Storage posible sin cambiar UI (repositorios).

---

## ADR-004 — Decision: i18n manual ES/EN en Fase 0, migrar a codegen después

Date: 2026-10-09

### Decision
`AppStrings` abstracto + `EsStrings`/`EnStrings` leídos vía `stringsProvider`; widgets prohibidos de hardcodear.

### Context
Evitar `gen-l10n`/slang en fundación para cerrar Fase 0 rápido con tests.

### Consequences
Añadir texto = añadir getter en 2 clases + test. Migración futura a slang no toca widgets (solo el provider).

### Alternatives considered
flutter gen-l10n, slang desde día 1.

### Reason
Simplicidad y `flutter analyze/test` verdes ya.

---

## ADR-005 — Decision: Schema Fase 1 con trigger auto-perfil y RLS por usuario

Date: 2026-10-12

### Decision
Tablas `profiles` (1:1 con auth.users) y `diary_entries` con RLS `auth.uid() = user_id`, trigger `handle_new_user()` que crea el perfil al registrarse, migración versionada en `supabase/migrations/` aplicada con `supabase db push --linked`.

### Context
Sin perfil automático el registro dejaba usuarios sin fila y el home fallaba; RLS evita lecturas cruzadas entre estudiantes en la demo.

### Consequences
El signup funciona end-to-end sin paso manual. Cambios futuros de schema van en nuevas migraciones, nunca editando la aplicada.

### Alternatives considered
Crear perfil desde el cliente tras signup (doble escritura, raza con RLS).

### Reason
Una sola fuente de verdad en DB, cliente solo lee/actualiza metas.

---

## ADR-006 — Decision: Tipos Dart puros en firmas de providers Riverpod

Date: 2026-10-12

### Decision
Firmas de providers solo con `String/int/double/bool/DateTime` y clases freezed; enums (`MealType`) se pasan como `String` (`mealName`) y se parsean dentro; filtros por slot como función pura `mealEntriesSync`.

### Context
`riverpod_generator 4.0.9` abortaba con `InvalidTypeException` sin detalle cuando las firmas incluían imports no resolubles; además se detectaron imports relativos con un nivel de menos en los providers nuevos.

### Consequences
Menos superficie de codegen; el dominio (`MealTypeX.parse`) sigue testeado. Si se actualiza el generador se puede revertir.

### Alternatives considered
Providers manuales sin generator.

### Reason
Mantiene el estándar Riverpod-generator de AGENTS.md con el mínimo cambio.

---

## ADR-007 — Decision: Sincronización en tiempo real con Supabase Realtime

Date: 2026-10-12

### Decision
Publicar `diary_entries` y `profiles` en la publicación `supabase_realtime` (migración `20261012150000_fase2_realtime.sql`). `core/services/realtime_service.dart` suscribe a `postgres_changes` filtrando por `user_id`/`id` del usuario; los repositorios exponen `watchChanges()` y los providers invalidan las cachés (`dayEntries`, `dayTotals`, `userSettings`).

### Context
Los cambios sí se guardaban en Supabase, pero la UI seguía mostrando datos viejos hasta cerrar sesión. Además el provider de perfil quedaba colgado al invalidarse porque leía `authUserIdProvider.future` (un StreamProvider): tras `invalidate` esperaba el siguiente evento de auth, que nunca llegaba.

### Consequences
La UI refleja cambios de este u otro dispositivo al instante. Cada escritura local provoca una invalidación extra (refetch) — aceptable a esta escala.

### Alternatives considered
Polling periódico (latencia y carga), recargar al volver a la pantalla (no cubre otros dispositivos), Broadcast por canal (requiere triggers en DB).

### Reason
Realtime es la solución nativa de Supabase, respeta RLS y no requiere triggers adicionales.

---

## ADR-008 — Decision: El perfil del usuario vive en `core` (UserSettings + port)

Date: 2026-10-12

### Decision
`core/models/user_settings.dart`, `core/ports/user_settings_port.dart`, `core/data/user_settings_port_impl.dart` (Supabase) y `core/providers/user_settings_provider.dart`. `auth_profile` conserva autenticación y la UI del perfil; `diary` consume `userSettingsProvider` de core.

### Context
`features/diary` importaba `features/auth_profile` para leer la meta calórica, violando la regla de AGENTS.md de que los features no se importan entre sí.

### Consequences
Ningún feature importa a otro. El port permite sustituir el backend en tests. La feature `auth_profile` queda con auth + páginas.

### Alternatives considered
Dejar el import cruzado, o mover el modelo completo a `core`.

### Reason
El perfil es un concepto transversal (diario, progreso, perfil) y el port mantiene el dominio testeable.

---

## ADR-009 — Decision: El escaneo de IA no persiste la foto; el resultado viaja como DTO

Date: 2026-10-12

### Decision
Sin Storage: la foto se procesa en memoria por Gemini y solo se guardan los números en `diary_entries` (`source='scan'`). El resultado cruza de `food_scan` a `diary` como `core/models/nutrition_item.dart` (DTO simple) y la página de confirmación editable vive en el feature `diary` (es quien escribe en el diario).

### Context
Evitar buckets y costs de Storage, y evitar que `food_scan` importe `diary` (o viceversa).

### Consequences
No se puede re-analizar una foto después; el usuario confirma y corrige los valores antes de guardar. La foto desaparece al salir de la pantalla.

### Alternatives considered
Guardar la foto en Storage; permitir imports entre features.

### Reason
Alcance universitario + regla de features independientes; la corrección manual obligatoria mejora la precisión.

---

## ADR-010 — Decision: Parser de Gemini tolerante pero con salida JSON estricta

Date: 2026-10-12

### Decision
`GeminiFoodScanner` pide `responseMimeType: application/json` con un prompt de formato exacto; `FoodEstimateParser` (puro, testeado) tolera fences markdown, prosa alrededor, objeto único, números como string y clamp de `confidence`; ante JSON inválido lanza `Failure`.

### Context
Los modelos no siempre devuelven JSON puro; un parser frágil rompía el flujo completo.

### Consequences
El parser es la pieza más testada de la feature (8 casos). Si Gemini devuelve `[]` se muestra el fallback manual.

### Alternatives considered
Parsing estricto con `jsonDecode` directo; pedir respuesta en Markdown formateado.

### Reason
El prompt hace el trabajo pesado y el parser es la red de seguridad, ambos verificables sin red.

---

## ADR-011 — Decision: Guard de rutas por sesión + navegación por resultado de la acción

Date: 2026-10-12

### Decision
1. `go_router` con `redirect` que evalúa la sesión en cada navegación: rutas públicas (`/onboarding`, `/login`) y el resto protegidas. Con sesión activa las públicas redirigen a `/home`; sin sesión las protegidas van a `/login`.
2. Las acciones de autenticación devuelven su resultado (`bool`) y la UI navega en consecuencia, en lugar de esperar un cambio en el stream de sesión.
3. El estado de sesión es un `Notifier` con `keepAlive()` y suscripción propia (no un `StreamProvider` auto-dispose).

### Context
El login "no funcionaba" tras reiniciar: `onAuthStateChange` es un `ReplaySubject`, así que la sesión persistida ya estaba disponible antes de montar la pantalla de login y el id nunca cambiaba → un listener basado en cambios del stream no disparaba, pese a que Supabase respondía 200. Además el `StreamProvider` auto-dispose se destruía y recreaba en cada navegación, generando ventanas de estado inconsistente.

### Consequences
La sesión persiste entre reinicios (se entra directo a /home). El estado de sesión es estable y único para guard, realtime y UI. El router debe vivir en un provider para poder leer la sesión.

### Alternatives considered
Solo corregir el listener (parche局部, sin guard); polling del estado de sesión; cerrar sesión automáticamente al abrir.

### Reason
El guard resuelve el síntoma y la causa; la navegación por resultado elimina la dependencia de transiciones de estado, que es la fuente real del bug.

---

## ADR-012 — Decision: Datos corporales en el signUp vía trigger; pesos en `weight_logs`

Date: 2026-11-17

### Decision
1. Peso, estatura, objetivo y peso meta se envían en `raw_user_meta_data` del `signUp` y el trigger `handle_new_user` los guarda (perfil con `height_cm`/`goal_weight_kg` y primer registro en `weight_logs`). Valores inválidos se ignoran en el trigger: nunca bloquean el registro.
2. El historial de peso vive en una tabla propia `weight_logs` (un peso por usuario y día, `unique (user_id, date)`, upsert), no como columna del perfil.
3. El peso actual y el IMC se derivan del último registro; la estatura y el peso meta son datos del perfil (`UserSettings`).
4. El cliente envía la fecha local (`weight_date`) porque el servidor usa UTC.
5. Las recetas son un catálogo estático bilingüe en `assets/recipes/recipes.json` (no en la base de datos).

### Context
Con confirmación de correo activa, `signUp` no devuelve sesión, así que escribir el perfil/peso desde el cliente fallaría por RLS. El trigger ya existía para crear el perfil. Para la gráfica se necesita historial, no un único valor.

### Consequences
Usuarios anteriores tienen `height_cm`/`goal_weight_kg` en null: la UI lo contempla (tarjetas con CTA al perfil). Cambiar rangos obliga a tocar a la vez `BodyLimits` y los CHECK de la migración. Agregar recetas = editar el JSON (sin migración).

### Alternatives considered
Escribir desde el cliente tras el signUp (falla sin sesión); columna `weight` en `profiles` (sin historial); recetas en Supabase (más infraestructura sin necesidad para un catálogo pequeño).

### Reason
Es la opción que funciona con y sin confirmación de correo, mantiene RLS intacto y permite graficar la evolución.

---

## ADR-013 — Decision: Assets de marca/recetas y respeto de los insets del sistema

Date: 2026-11-20

### Decision
1. El logo de marca se copia a `assets/images/logo.jpg` y se expone como `core/widgets/app_logo.dart` (`AppLogo`), reutilizable por cualquier feature.
2. Las fotos de recetas viven en `lib/recipes_pictures/` (como pidió el usuario), se declaran en `pubspec.yaml` y se referencian desde `Recipe.image`; `RecipeImage` usa `Image.asset` y cae al emoji de la receta si el asset falta.
3. Las pantallas con contenido o acciones al final del scroll envuelven el body en `SafeArea(top: false)` cuando no tienen `bottomNavigationBar`, para no dibujar bajo la barra de navegación/gestos de Android.

### Context
Android 15+ fuerza edge-to-edge: el contenido se dibuja debajo de las barras del sistema. Los botones al final de listas largas (detalle de receta, resultados del escaneo, confirmación/guardado en el diario) quedaban tapados por la barra de navegación.

### Consequences
Los CTAs quedan siempre accesibles al llegar al final del scroll. Las imágenes se resuelven offline (sin Supabase Storage) y hay fallback visual. Cualquier pantalla nueva con scroll debe usar `SafeArea(top: false)` si no tiene `bottomNavigationBar`; si lo tiene, la barra debe llevar su propio `SafeArea`.

### Alternatives considered
Activar/desactivar edge-to-edge manualmente (rompe el comportamiento estándar de Android 15); calcular padding a mano en cada página (duplicación y errores); subir las fotos a Supabase Storage (fuera del alcance: sin Storage).

### Reason
`SafeArea` es la solución idiomática de Flutter para los insets y el bundle local mantiene el recetario offline y sin infraestructura extra.

