import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/nutrition_calc.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/weight_summary.dart';

/// Colour of each BMI category (also used by the scale below).
const _categoryColors = {
  BmiCategory.underweight: AppColors.carbs,
  BmiCategory.normal: AppColors.primary,
  BmiCategory.overweight: AppColors.fat,
  BmiCategory.obese: AppColors.protein,
};

/// BMI value, category and a small scale with a marker.
class BmiCard extends ConsumerWidget {
  const BmiCard({super.key, required this.summary});

  final WeightSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final theme = Theme.of(context);
    final bmi = summary.bmi;
    final category = summary.bmiCategoryValue;

    if (summary.heightCm == null) {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.addHeightHint),
            TextButton(
              onPressed: () => context.go('/profile'),
              child: Text(strings.goToProfile),
            ),
          ],
        ),
      );
    }
    if (bmi == null || category == null) {
      return AppCard(child: Text(strings.bmiNeedsWeight));
    }

    final color = _categoryColors[category] ?? AppColors.primary;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.bmi, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(bmi.toStringAsFixed(1), style: theme.textTheme.titleLarge),
              const SizedBox(width: 12),
              Chip(
                label: Text(strings.bmiCategoryLabel(category)),
                backgroundColor: color.withValues(alpha: 0.18),
                side: BorderSide.none,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _BmiScale(bmi: bmi),
          const SizedBox(height: 8),
          Text(strings.bmiAdultNote, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// Four coloured segments (15–40 BMI) with a marker at the user's value.
class _BmiScale extends StatelessWidget {
  const _BmiScale({required this.bmi});

  final double bmi;

  static const double _min = 15;
  static const double _max = 40;

  @override
  Widget build(BuildContext context) {
    final fraction = ((bmi - _min) / (_max - _min)).clamp(0.0, 1.0).toDouble();
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const SizedBox(
            height: 8,
            child: Row(
              children: [
                Expanded(flex: 35, child: ColoredBox(color: AppColors.carbs)),
                Expanded(flex: 65, child: ColoredBox(color: AppColors.primary)),
                Expanded(flex: 50, child: ColoredBox(color: AppColors.fat)),
                Expanded(flex: 100, child: ColoredBox(color: AppColors.protein)),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(fraction * 2 - 1, 0),
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
