# Project: NutriFit (Flutter)

## Tech Stack
Stable Flutter, Riverpod (generator), go_router, freezed, fl_chart, [Supabase].

## Architecture
Feature-first with data/domain/presentation layers. The UI never accesses
data sources; only providers that use repositories. Features do not
import from one another.

## Conventions
- Immutable models with `freezed`; no `dynamic`.
- All visible text goes in i18n (en). Do not hardcode strings.
- Async states with `AsyncValue`; always handle loading and errors.
- Small widgets (< ~150 lines); extract them if they grow.
- No business logic in widgets.
- File names in snake_case; one public widget per file.

## Commands
- `dart run build_runner build -d`
- `flutter analyze` and `flutter test` must run successfully before marking a task as complete.

## Project Memory

Before modifying code:

1. Read `docs/PROJECT_STATE.md`.
2. Read the specific documentation for the feature in question, if available.

After modifying code:

1. Update `docs/PROJECT_STATE.md` if the architectural or functional state has changed.
2. Record the work done in `docs/CHANGELOG_AI.md`.
3. Record new architectural decisions in `docs/DECISIONS.md`.

`docs/PROJECT_STATE.md` file should always be kept as short as possible

The information provided in the `/PROJECT_STATE.md`, `/CHANGELOG_AI.md`, and `/DECISIONS.md` files must always be documented in the format specified in those files. 

The changelog should describe actual changes made, not planned changes.

Do not delete historical entries from the changelog.

## Out of Scope (Do Not Add)
Payments, social features, push notifications, barcode scanning, wearables.

## Upon Completing a Task
List the files modified, how to test them, and what remains to be done.