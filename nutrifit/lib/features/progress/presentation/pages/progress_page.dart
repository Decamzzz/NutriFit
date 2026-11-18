import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../providers/weight_providers.dart';
import '../widgets/bmi_card.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/log_weight_sheet.dart';
import '../widgets/weight_card.dart';
import '../widgets/weight_history_card.dart';

/// screen5: weight evolution, goal progress and BMI. No business logic
/// here: everything comes precomputed from [weightSummaryProvider].
class ProgressPage extends ConsumerWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final summaryAsync = ref.watch(weightSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(strings.progress)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            showLogWeightSheet(context, initialKg: summaryAsync.value?.currentKg),
        icon: const Icon(Icons.add),
        label: Text(strings.logWeight),
      ),
      body: summaryAsync.when(
        loading: () => AppLoader(label: strings.loading),
        error: (e, _) => AppErrorView(
          message: e.toString(),
          retryLabel: strings.retry,
          onRetry: () => ref.invalidate(weightLogsProvider),
        ),
        data: (summary) => ListView(
          // Bottom padding keeps the last card clear of the FAB.
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            WeightCard(summary: summary),
            const SizedBox(height: 12),
            GoalProgressCard(summary: summary),
            const SizedBox(height: 12),
            BmiCard(summary: summary),
            if (!summary.isEmpty) ...[
              const SizedBox(height: 12),
              WeightHistoryCard(summary: summary),
            ],
          ],
        ),
      ),
    );
  }
}
