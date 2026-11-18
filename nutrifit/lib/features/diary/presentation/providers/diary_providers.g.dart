// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(diaryRepository)
final diaryRepositoryProvider = DiaryRepositoryProvider._();

final class DiaryRepositoryProvider
    extends
        $FunctionalProvider<DiaryRepository, DiaryRepository, DiaryRepository>
    with $Provider<DiaryRepository> {
  DiaryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diaryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diaryRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiaryRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DiaryRepository create(Ref ref) {
    return diaryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiaryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiaryRepository>(value),
    );
  }
}

String _$diaryRepositoryHash() => r'64949dda2995f2fdbe40f60e9b3e22276dfa41af';

/// Selected day for the diary (defaults to today). Home/add-food share it.

@ProviderFor(DiaryDay)
final diaryDayProvider = DiaryDayProvider._();

/// Selected day for the diary (defaults to today). Home/add-food share it.
final class DiaryDayProvider extends $NotifierProvider<DiaryDay, DateTime> {
  /// Selected day for the diary (defaults to today). Home/add-food share it.
  DiaryDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diaryDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diaryDayHash();

  @$internal
  @override
  DiaryDay create() => DiaryDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$diaryDayHash() => r'3855566c48ab1a6efdea33a18fd08e2dc4d6c6bc';

/// Selected day for the diary (defaults to today). Home/add-food share it.

abstract class _$DiaryDay extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Entries for a yyyy-MM-dd day. Invalidated after add/remove.

@ProviderFor(dayEntries)
final dayEntriesProvider = DayEntriesFamily._();

/// Entries for a yyyy-MM-dd day. Invalidated after add/remove.

final class DayEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DiaryEntry>>,
          List<DiaryEntry>,
          FutureOr<List<DiaryEntry>>
        >
    with $FutureModifier<List<DiaryEntry>>, $FutureProvider<List<DiaryEntry>> {
  /// Entries for a yyyy-MM-dd day. Invalidated after add/remove.
  DayEntriesProvider._({
    required DayEntriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dayEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayEntriesHash();

  @override
  String toString() {
    return r'dayEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DiaryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DiaryEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return dayEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayEntriesHash() => r'd2cc00e47db02998862ad07990112871cc1b4fe5';

/// Entries for a yyyy-MM-dd day. Invalidated after add/remove.

final class DayEntriesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DiaryEntry>>, String> {
  DayEntriesFamily._()
    : super(
        retry: null,
        name: r'dayEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Entries for a yyyy-MM-dd day. Invalidated after add/remove.

  DayEntriesProvider call(String ymdDate) =>
      DayEntriesProvider._(argument: ymdDate, from: this);

  @override
  String toString() => r'dayEntriesProvider';
}

/// Summed nutrients for a day.

@ProviderFor(dayTotals)
final dayTotalsProvider = DayTotalsFamily._();

/// Summed nutrients for a day.

final class DayTotalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MacroTotals>,
          MacroTotals,
          FutureOr<MacroTotals>
        >
    with $FutureModifier<MacroTotals>, $FutureProvider<MacroTotals> {
  /// Summed nutrients for a day.
  DayTotalsProvider._({
    required DayTotalsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dayTotalsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayTotalsHash();

  @override
  String toString() {
    return r'dayTotalsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MacroTotals> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MacroTotals> create(Ref ref) {
    final argument = this.argument as String;
    return dayTotals(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayTotalsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayTotalsHash() => r'9b23211689bf0273ede28cdbf450155654073c78';

/// Summed nutrients for a day.

final class DayTotalsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MacroTotals>, String> {
  DayTotalsFamily._()
    : super(
        retry: null,
        name: r'dayTotalsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Summed nutrients for a day.

  DayTotalsProvider call(String ymdDate) =>
      DayTotalsProvider._(argument: ymdDate, from: this);

  @override
  String toString() => r'dayTotalsProvider';
}

/// Keeps the diary in sync with Supabase Realtime: inserts, updates or
/// deletes (from this or another device) refresh the cached day.

@ProviderFor(diaryRealtimeSync)
final diaryRealtimeSyncProvider = DiaryRealtimeSyncProvider._();

/// Keeps the diary in sync with Supabase Realtime: inserts, updates or
/// deletes (from this or another device) refresh the cached day.

final class DiaryRealtimeSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  /// Keeps the diary in sync with Supabase Realtime: inserts, updates or
  /// deletes (from this or another device) refresh the cached day.
  DiaryRealtimeSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diaryRealtimeSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diaryRealtimeSyncHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return diaryRealtimeSync(ref);
  }
}

String _$diaryRealtimeSyncHash() => r'09c566efe58b810d55fc3a5989c4e83c5f14abf0';

/// Add/remove controller. UI watches AsyncValue for feedback.

@ProviderFor(DiaryEditor)
final diaryEditorProvider = DiaryEditorProvider._();

/// Add/remove controller. UI watches AsyncValue for feedback.
final class DiaryEditorProvider
    extends $AsyncNotifierProvider<DiaryEditor, void> {
  /// Add/remove controller. UI watches AsyncValue for feedback.
  DiaryEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diaryEditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diaryEditorHash();

  @$internal
  @override
  DiaryEditor create() => DiaryEditor();
}

String _$diaryEditorHash() => r'7cca23315ed6c8956e2ad0fed9159b8d1acfe765';

/// Add/remove controller. UI watches AsyncValue for feedback.

abstract class _$DiaryEditor extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
