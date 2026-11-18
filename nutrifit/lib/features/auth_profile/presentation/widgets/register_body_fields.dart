import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/body_metrics.dart';
import '../../../../core/utils/nutrition_calc.dart';
import '../pages/profile_page.dart' show goalLabel;

const _goals = ['lose', 'maintain', 'gain'];

final _decimalFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];

/// Body section of the sign-up form: weight, height, live BMI preview,
/// goal and goal weight. The parent owns the controllers and the goal.
class RegisterBodyFields extends ConsumerWidget {
  const RegisterBodyFields({
    super.key,
    required this.weight,
    required this.height,
    required this.goalWeight,
    required this.goal,
    required this.onGoalChanged,
  });

  final TextEditingController weight;
  final TextEditingController height;
  final TextEditingController goalWeight;
  final String goal;
  final ValueChanged<String> onGoalChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final theme = Theme.of(context);
    const decimal = TextInputType.numberWithOptions(decimal: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(strings.yourData, style: theme.textTheme.titleMedium),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: weight,
                decoration: InputDecoration(labelText: strings.weight),
                keyboardType: decimal,
                inputFormatters: _decimalFormatters,
                validator: (v) => isValidWeightKg(parseDecimal(v ?? ''))
                    ? null
                    : strings.invalidWeight,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: height,
                decoration: InputDecoration(labelText: strings.height),
                keyboardType: decimal,
                inputFormatters: _decimalFormatters,
                validator: (v) => isValidHeightCm(parseDecimal(v ?? ''))
                    ? null
                    : strings.invalidHeight,
              ),
            ),
          ],
        ),
        _BmiPreview(weight: weight, height: height),
        const SizedBox(height: 16),
        Text(strings.yourGoal, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final g in _goals)
              ChoiceChip(
                label: Text(goalLabel(strings, g)),
                selected: goal == g,
                onSelected: (_) => onGoalChanged(g),
              ),
          ],
        ),
        if (goal != 'maintain')
          TextFormField(
            controller: goalWeight,
            decoration: InputDecoration(labelText: strings.goalWeight),
            keyboardType: decimal,
            inputFormatters: _decimalFormatters,
            validator: (v) {
              final issue = validateGoalWeight(
                goal: goal,
                currentKg: parseDecimal(weight.text),
                goalKg: parseDecimal(v ?? ''),
              );
              return switch (issue) {
                null => null,
                GoalWeightIssue.invalid => strings.invalidGoalWeight,
                GoalWeightIssue.mustBeLower => strings.goalMustBeLower,
                GoalWeightIssue.mustBeHigher => strings.goalMustBeHigher,
              };
            },
          ),
      ],
    );
  }
}

/// "Tu IMC: 24.1 · Peso normal", updated while the user types.
class _BmiPreview extends ConsumerWidget {
  const _BmiPreview({required this.weight, required this.height});

  final TextEditingController weight;
  final TextEditingController height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return ListenableBuilder(
      listenable: Listenable.merge([weight, height]),
      builder: (context, _) {
        final w = parseDecimal(weight.text);
        final h = parseDecimal(height.text);
        if (w == null || h == null || !isValidWeightKg(w) || !isValidHeightCm(h)) {
          return const SizedBox.shrink();
        }
        final bmi = calcBmi(weightKg: w, heightCm: h);
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            '${strings.bmiValue(bmi.toStringAsFixed(1))} · '
            '${strings.bmiCategoryLabel(bmiCategory(bmi))}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        );
      },
    );
  }
}
