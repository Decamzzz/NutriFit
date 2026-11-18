import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/session_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/diary_repository_impl.dart';
import '../../domain/diary_entry.dart';
import '../../domain/diary_repository.dart';
import '../../domain/macro_totals.dart';
import '../../domain/meal_type.dart';

part 'diary_providers.g.dart';

@riverpod
DiaryRepository diaryRepository(Ref ref) => SupabaseDiaryRepository();

/// Selected day for the diary (defaults to today). Home/add-food share it.
@riverpod
class DiaryDay extends _$DiaryDay {
  @override
  DateTime build() => startOfDay(DateTime.now());

  void set(DateTime day) => state = startOfDay(day);
}

/// Entries for a yyyy-MM-dd day. Invalidated after add/remove.
@riverpod
Future<List<DiaryEntry>> dayEntries(Ref ref, String ymdDate) async {
  final parts = ymdDate.split('-').map(int.parse).toList();
  final day = DateTime(parts[0], parts[1], parts[2]);
  return ref.watch(diaryRepositoryProvider).fetchDay(day);
}

/// Summed nutrients for a day.
@riverpod
Future<MacroTotals> dayTotals(Ref ref, String ymdDate) async {
  final entries = await ref.watch(dayEntriesProvider(ymdDate).future);
  return MacroTotals.fromEntries(entries);
}

/// Keeps the diary in sync with Supabase Realtime: inserts, updates or
/// deletes (from this or another device) refresh the cached day.
@riverpod
Stream<void> diaryRealtimeSync(Ref ref) async* {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId.isEmpty) return;
  await for (final _ in ref.watch(diaryRepositoryProvider).watchChanges()) {
    ref.invalidate(dayEntriesProvider);
    ref.invalidate(dayTotalsProvider);
  }
}

/// Entries filtered by meal slot. Client-side filter over [dayEntries].
List<DiaryEntry> mealEntriesSync(List<DiaryEntry> entries, MealType meal) =>
    entries.where((e) => e.mealType == meal.tableValue).toList();

/// Add/remove controller. UI watches AsyncValue for feedback.
@riverpod
class DiaryEditor extends _$DiaryEditor {
  @override
  FutureOr<void> build() {}

  Future<void> add({
    required DateTime day,
    required String mealName,
    required String foodName,
    required double grams,
    required double kcal,
    required double protein,
    required double carbs,
    required double fat,
    String source = 'manual',
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(diaryRepositoryProvider)
          .addEntry(
            day: day,
            meal: MealTypeX.parse(mealName),
            foodName: foodName,
            grams: grams,
            kcal: kcal,
            protein: protein,
            carbs: carbs,
            fat: fat,
            source: source,
          );
      ref.invalidate(dayEntriesProvider);
      ref.invalidate(dayTotalsProvider);
    });
  }

  Future<void> remove(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(diaryRepositoryProvider).removeEntry(id);
      ref.invalidate(dayEntriesProvider);
      ref.invalidate(dayTotalsProvider);
    });
  }
}
