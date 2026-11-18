import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';

/// One meal slot card (screen2): icon, name, summary, kcal, add button.
class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.kcalLabel,
    required this.icon,
    required this.onAdd,
  });

  final String title;
  final String subtitle;
  final String kcalLabel;
  final IconData icon;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(child: Icon(icon)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      kcalLabel,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(onPressed: onAdd, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
