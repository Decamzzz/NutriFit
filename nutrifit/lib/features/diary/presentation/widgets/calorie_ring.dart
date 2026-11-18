import 'package:flutter/material.dart';

/// Daily kcal ring (screen2): consumed vs target, remaining in the middle.
class CalorieRing extends StatelessWidget {
  const CalorieRing({
    super.key,
    required this.consumed,
    required this.target,
    required this.remainingLabel,
  });

  final double consumed;
  final double target;
  final String remainingLabel;

  @override
  Widget build(BuildContext context) {
    final progress = target <= 0 ? 0.0 : (consumed / target).clamp(0.0, 1.0);
    final remaining = (target - consumed).round();
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            backgroundColor: scheme.surfaceContainerHighest,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$remaining',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                remainingLabel,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
