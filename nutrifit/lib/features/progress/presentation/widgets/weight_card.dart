import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/body_metrics.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/weight_chart_data.dart';
import '../../domain/weight_summary.dart';
import 'weight_chart.dart';

/// Current weight, change in the last 7 days and the evolution chart.
class WeightCard extends ConsumerWidget {
  const WeightCard({super.key, required this.summary});

  final WeightSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final theme = Theme.of(context);
    final current = summary.currentKg;
    final weekly = summary.weeklyChange;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.currentWeight, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  current == null ? strings.notSet : strings.kgValue(current),
                  style: theme.textTheme.titleLarge,
                ),
              ),
              if (weekly != null)
                Chip(
                  label: Text(strings.weightChange7d(formatSignedKg(weekly))),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (summary.isEmpty)
            Text(strings.noWeightYet)
          else ...[
            WeightChart(
              data: WeightChartData.from(
                logs: summary.logs,
                goalKg: summary.goalWeightKg,
              ),
              goalLabel: strings.goalLine,
            ),
            if (summary.logs.length < 2)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  strings.chartNeedsTwo,
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
