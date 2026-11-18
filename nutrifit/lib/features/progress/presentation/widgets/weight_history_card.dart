import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/weight_summary.dart';
import '../providers/weight_providers.dart';

/// Most recent weight entries (newest first) with delete.
class WeightHistoryCard extends ConsumerWidget {
  const WeightHistoryCard({super.key, required this.summary});

  final WeightSummary summary;

  static const int _maxItems = 15;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final strings = ref.read(stringsProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(strings.confirmDeleteWeight),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(strings.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(weightEditorProvider.notifier).remove(id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final l10n = MaterialLocalizations.of(context);
    final recent = summary.logs.reversed.take(_maxItems).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.weightHistory,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final log in recent)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(strings.kgValue(log.weightKg)),
              subtitle: Text(l10n.formatMediumDate(parseYmd(log.date))),
              trailing: log.id == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: strings.delete,
                      onPressed: () => _confirmDelete(context, ref, log.id!),
                    ),
            ),
        ],
      ),
    );
  }
}
