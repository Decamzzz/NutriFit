import 'package:flutter/material.dart';

/// One macronutrient figure (e.g. "P" / "24 g") with its brand colour.
class MacroTile extends StatelessWidget {
  const MacroTile({
    super.key,
    required this.label,
    required this.grams,
    required this.color,
  });

  final String label;
  final double grams;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          '${grams.toStringAsFixed(0)} g',
          style: theme.textTheme.titleMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 2),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
