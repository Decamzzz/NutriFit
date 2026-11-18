import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/providers/user_settings_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/meal_type.dart';
import '../providers/diary_providers.dart';
import '../widgets/calorie_ring.dart';
import '../widgets/macro_bar.dart';
import '../widgets/meal_card.dart';

/// screen2: daily dashboard. No business logic; only watches providers.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final day = ref.watch(diaryDayProvider);
    final ymdDate = ymd(day);
    final profileAsync = ref.watch(userSettingsProvider);
    final totalsAsync = ref.watch(dayTotalsProvider(ymdDate));

    return Scaffold(
      appBar: AppBar(title: Text(strings.home)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        icon: const Icon(Icons.camera_alt_outlined),
        label: Text(strings.scanFood),
      ),
      body: profileAsync.when(
        loading: () => AppLoader(label: strings.loading),
        error: (e, _) => AppErrorView(
          message: strings.supabaseNotConfigured,
          retryLabel: strings.retry,
          onRetry: () => ref.invalidate(userSettingsProvider),
        ),
        data: (profile) {
          if (profile == null) {
            return Center(
              child: FilledButton(
                onPressed: () => context.go('/login'),
                child: Text(strings.login),
              ),
            );
          }
          final target = profile.calorieTarget;
          return totalsAsync.when(
            loading: () => AppLoader(label: strings.loading),
            error: (e, _) => AppErrorView(
              message: e.toString(),
              retryLabel: strings.retry,
              onRetry: () => ref.invalidate(dayTotalsProvider),
            ),
            data: (totals) {
              final proteinGoal = target * 0.25 / 4;
              final carbsGoal = target * 0.50 / 4;
              final fatGoal = target * 0.25 / 9;
              final scheme = Theme.of(context).colorScheme;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    strings.greeting(profile.name ?? profile.email ?? ''),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Row(
                      children: [
                        CalorieRing(
                          consumed: totals.kcal,
                          target: target.toDouble(),
                          remainingLabel: strings.remaining,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _StatRow(
                                label:
                                    '${strings.target}: ${strings.kcalValue(target)}',
                              ),
                              _StatRow(
                                label:
                                    '${strings.foods}: ${strings.kcalValue(totals.kcal.round())}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.macroDistribution,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        MacroBar(
                          label: strings.proteins,
                          current: totals.protein,
                          goal: proteinGoal,
                          color: const Color(0xFFF43F5E),
                          unit: 'g',
                        ),
                        const SizedBox(height: 10),
                        MacroBar(
                          label: strings.carbs,
                          current: totals.carbs,
                          goal: carbsGoal,
                          color: const Color(0xFF0EA5E9),
                          unit: 'g',
                        ),
                        const SizedBox(height: 10),
                        MacroBar(
                          label: strings.fats,
                          current: totals.fat,
                          goal: fatGoal,
                          color: const Color(0xFFF59E0B),
                          unit: 'g',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    strings.mealLog,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final meal in MealType.values) ...[
                    _MealSlotCard(
                      ymdDate: ymdDate,
                      meal: meal,
                      schemeColor: scheme.primary,
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _MealSlotCard extends ConsumerWidget {
  const _MealSlotCard({
    required this.ymdDate,
    required this.meal,
    required this.schemeColor,
  });

  final String ymdDate;
  final MealType meal;
  final Color schemeColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final entriesAsync = ref.watch(dayEntriesProvider(ymdDate));
    final title = switch (meal) {
      MealType.breakfast => strings.breakfast,
      MealType.lunch => strings.lunch,
      MealType.dinner => strings.dinner,
      MealType.snack => strings.snack,
    };
    final icon = switch (meal) {
      MealType.breakfast => Icons.coffee_outlined,
      MealType.lunch => Icons.wb_sunny_outlined,
      MealType.dinner => Icons.nights_stay_outlined,
      MealType.snack => Icons.cookie_outlined,
    };
    return entriesAsync.when(
      loading: () => AppCard(child: Text(title)),
      error: (_, _) => AppCard(child: Text(title)),
      data: (all) {
        final entries = mealEntriesSync(all, meal);
        final kcal = entries.fold<double>(0, (s, e) => s + e.kcal);
        final subtitle = entries.isEmpty
            ? strings.notLoggedYet
            : entries.map((e) => e.foodName).join(', ');
        return MealCard(
          title: title,
          subtitle: subtitle,
          kcalLabel: strings.kcalValue(kcal.round()),
          icon: icon,
          onAdd: () => context.push('/add-food/${meal.name}'),
        );
      },
    );
  }
}
