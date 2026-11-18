import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/food_estimate.dart';

/// List of foods detected by the AI, with the action to add them to the diary.
class ScanResults extends StatelessWidget {
  const ScanResults({
    super.key,
    required this.estimates,
    required this.title,
    required this.actionLabel,
    required this.onAddToDiary,
  });

  final List<FoodEstimate> estimates;
  final String title;
  final String actionLabel;
  final VoidCallback onAddToDiary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final estimate in estimates)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _EstimateCard(estimate: estimate),
          ),
        const SizedBox(height: 8),
        AppButton(label: actionLabel, onPressed: onAddToDiary),
      ],
    );
  }
}

class _EstimateCard extends StatelessWidget {
  const _EstimateCard({required this.estimate});

  final FoodEstimate estimate;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  estimate.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  '${estimate.grams.toStringAsFixed(0)} g · '
                  'P: ${estimate.protein.toStringAsFixed(1)}g · '
                  'C: ${estimate.carbs.toStringAsFixed(1)}g · '
                  'G: ${estimate.fat.toStringAsFixed(1)}g',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${estimate.kcal.toStringAsFixed(0)} kcal',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
