import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/weight_summary.dart';

/// Progress bar from the starting weight toward the goal weight.
class GoalProgressCard extends ConsumerWidget {
  const GoalProgressCard({super.key, required this.summary});

  final WeightSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final theme = Theme.of(context);
    final goal = summary.goalWeightKg;

    if (goal == null) {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.setGoalWeightHint),
            TextButton(
              onPressed: () => context.go('/profile'),
              child: Text(strings.goToProfile),
            ),
          ],
        ),
      );
    }

    final progress = summary.goalProgress;
    final remaining = summary.remainingToGoal;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.goalProgress, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            strings.goalWeightValue(strings.kgValue(goal)),
            style: theme.textTheme.bodySmall,
          ),
          if (summary.goalReached) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.emoji_events_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(strings.goalReached, style: theme.textTheme.labelLarge),
              ],
            ),
          ] else if (progress != null && remaining != null) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${(progress * 100).round()}%'),
                Text(strings.remainingToGoal(strings.kgValue(remaining.abs()))),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
