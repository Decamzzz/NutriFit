import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/user_settings_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../providers/auth_providers.dart';
import '../widgets/body_data_card.dart';

const _goals = ['lose', 'maintain', 'gain'];
const _levels = ['sedentary', 'light', 'moderate', 'active'];

/// screen6: profile header + goal settings + app settings + sign out.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final settingsAsync = ref.watch(userSettingsProvider);
    final email = ref.watch(currentUserEmailProvider);

    return Scaffold(
      appBar: AppBar(title: Text(strings.profileTitle)),
      body: settingsAsync.when(
        loading: () => AppLoader(label: strings.loading),
        error: (e, _) => AppErrorView(
          message: e.toString(),
          retryLabel: strings.retry,
          onRetry: () => ref.invalidate(userSettingsProvider),
        ),
        data: (settings) {
          if (settings == null) {
            return Center(
              child: FilledButton(
                onPressed: () => context.go('/login'),
                child: Text(strings.login),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Text(
                        (settings.name ?? settings.email ?? '?')
                            .characters
                            .first
                            .toUpperCase(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            settings.name ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(email ?? settings.email ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.goalSettings,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppCard(
                child: Column(
                  children: [
                    _GoalRow(
                      label: strings.mainGoal,
                      value: goalLabel(strings, settings.goal),
                      onTap: () => _pickGoal(context, ref, settings.goal),
                    ),
                    const Divider(),
                    _GoalRow(
                      label: strings.activityLevel,
                      value: levelLabel(strings, settings.activityLevel),
                      onTap: () =>
                          _pickLevel(context, ref, settings.activityLevel),
                    ),
                    const Divider(),
                    _GoalRow(
                      label: strings.calorieTarget,
                      value: strings.kcalValue(settings.calorieTarget),
                      onTap: () => _pickCalories(
                        context,
                        ref,
                        settings.calorieTarget,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.bodyData,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              BodyDataCard(settings: settings),
              const SizedBox(height: 12),
              const _AppSettingsCard(),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).signOut();
                  if (context.mounted) context.go('/login');
                },
                child: Text(strings.signOut),
              ),
            ],
          );
        },
      ),
    );
  }
}

String goalLabel(AppStrings strings, String goal) => switch (goal) {
  'lose' => strings.goalLose,
  'gain' => strings.goalGain,
  _ => strings.goalMaintain,
};

String levelLabel(AppStrings strings, String level) => switch (level) {
  'sedentary' => strings.actSedentary,
  'light' => strings.actLight,
  'active' => strings.actActive,
  _ => strings.actModerate,
};

class _GoalRow extends StatelessWidget {
  const _GoalRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.labelLarge),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}

Future<void> _saveGoals(
  WidgetRef ref,
  BuildContext context, {
  String? goal,
  String? level,
  int? calories,
}) async {
  final settings = await ref.read(userSettingsProvider.future);
  if (settings == null || !context.mounted) return;
  await ref
      .read(userSettingsEditorProvider.notifier)
      .save(
        goal: goal ?? settings.goal,
        activityLevel: level ?? settings.activityLevel,
        calorieTarget: calories ?? settings.calorieTarget,
      );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ref.read(stringsProvider).saved),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

Future<void> _pickGoal(BuildContext context, WidgetRef ref, String current) async {
  final strings = ref.read(stringsProvider);
  final picked = await showDialog<String>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: Text(strings.mainGoal),
      children: [
        for (final g in _goals)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, g),
            child: Text(goalLabel(strings, g)),
          ),
      ],
    ),
  );
  if (picked != null && context.mounted) {
    await _saveGoals(ref, context, goal: picked);
  }
}

Future<void> _pickLevel(
  BuildContext context,
  WidgetRef ref,
  String current,
) async {
  final strings = ref.read(stringsProvider);
  final picked = await showDialog<String>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: Text(strings.activityLevel),
      children: [
        for (final l in _levels)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, l),
            child: Text(levelLabel(strings, l)),
          ),
      ],
    ),
  );
  if (picked != null && context.mounted) {
    await _saveGoals(ref, context, level: picked);
  }
}

Future<void> _pickCalories(
  BuildContext context,
  WidgetRef ref,
  int current,
) async {
  final strings = ref.read(stringsProvider);
  final controller = TextEditingController(text: '$current');
  final picked = await showDialog<int>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(strings.calorieTarget),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(strings.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.pop(ctx, int.tryParse(controller.text) ?? current),
          child: Text(strings.save),
        ),
      ],
    ),
  );
  if (picked != null && context.mounted) {
    await _saveGoals(ref, context, calories: picked.clamp(800, 10000));
  }
}

class _AppSettingsCard extends ConsumerWidget {
  const _AppSettingsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeSettingProvider);
    final locale = ref.watch(localeSettingProvider);
    return AppCard(
      child: Column(
        children: [
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.settings_suggest_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (s) =>
                ref.read(themeModeSettingProvider.notifier).set(s.first),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'es', label: Text('ES')),
              ButtonSegment(value: 'en', label: Text('EN')),
            ],
            selected: {locale.languageCode},
            onSelectionChanged: (s) => ref
                .read(localeSettingProvider.notifier)
                .set(Locale(s.first)),
          ),
        ],
      ),
    );
  }
}
