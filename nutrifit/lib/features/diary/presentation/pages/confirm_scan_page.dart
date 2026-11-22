import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/models/nutrition_item.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/meal_type.dart';
import '../providers/diary_providers.dart';

/// Editable confirmation of the AI estimates before saving them to the
/// diary. Lives in the diary feature because its job is writing entries.
class ConfirmScanPage extends ConsumerStatefulWidget {
  const ConfirmScanPage({
    super.key,
    this.items = const [],
    this.source = 'scan',
  });

  final List<NutritionItem> items;

  /// Stored in `diary_entries.source`: 'scan' (default) or 'recipe'.
  final String source;

  @override
  ConsumerState<ConfirmScanPage> createState() => _ConfirmScanPageState();
}

class _ConfirmScanPageState extends ConsumerState<ConfirmScanPage> {
  late final List<_EditableItem> _items = widget.items
      .map(_EditableItem.fromItem)
      .toList();
  String _meal = MealType.breakfast.name;

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final editor = ref.watch(diaryEditorProvider);
    final mealLabels = {
      MealType.breakfast.name: strings.breakfast,
      MealType.lunch.name: strings.lunch,
      MealType.dinner.name: strings.dinner,
      MealType.snack.name: strings.snack,
    };

    return Scaffold(
      appBar: AppBar(title: Text(strings.confirmScan)),
      // Keep the scrollable content (and the save button at its end) above
      // the system navigation bar / gesture area.
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_items.isEmpty)
              AppCard(
                child: Column(
                  children: [
                    Text(strings.emptyScan),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => context.go('/scan'),
                      child: Text(strings.scanFood),
                    ),
                  ],
                ),
              )
            else ...[
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.selectMeal,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _meal,
                      items: [
                        for (final entry in mealLabels.entries)
                          DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ),
                      ],
                      onChanged: (v) => setState(() => _meal = v ?? _meal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              for (final item in _items) ...[
                _EditableItemCard(item: item),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 8),
              AppButton(
                label: strings.saveToDiary,
                onPressed: editor.isLoading ? null : _save,
              ),
              if (editor.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    strings.saveError,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final day = ref.read(diaryDayProvider);
    for (final item in _items) {
      final values = item.values();
      if (values.name.trim().isEmpty) continue;
      await ref
          .read(diaryEditorProvider.notifier)
          .add(
            day: day,
            mealName: _meal,
            foodName: values.name,
            grams: values.grams,
            kcal: values.kcal,
            protein: values.protein,
            carbs: values.carbs,
            fat: values.fat,
            source: widget.source,
          );
    }
    if (mounted) {
      context.go('/home');
    }
  }
}

/// Editable copy of a scanned item.
class _EditableItem {
  _EditableItem({
    required this.name,
    required this.grams,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory _EditableItem.fromItem(NutritionItem item) => _EditableItem(
    name: TextEditingController(text: item.name),
    grams: TextEditingController(text: item.grams.toStringAsFixed(0)),
    kcal: TextEditingController(text: item.kcal.toStringAsFixed(0)),
    protein: TextEditingController(text: item.protein.toStringAsFixed(1)),
    carbs: TextEditingController(text: item.carbs.toStringAsFixed(1)),
    fat: TextEditingController(text: item.fat.toStringAsFixed(1)),
  );

  final TextEditingController name;
  final TextEditingController grams;
  final TextEditingController kcal;
  final TextEditingController protein;
  final TextEditingController carbs;
  final TextEditingController fat;

  NutritionItem values() => NutritionItem(
    name: name.text.trim(),
    grams: double.tryParse(grams.text.trim()) ?? 0,
    kcal: double.tryParse(kcal.text.trim()) ?? 0,
    protein: double.tryParse(protein.text.trim()) ?? 0,
    carbs: double.tryParse(carbs.text.trim()) ?? 0,
    fat: double.tryParse(fat.text.trim()) ?? 0,
  );
}

class _EditableItemCard extends ConsumerWidget {
  const _EditableItemCard({required this.item});

  final _EditableItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return AppCard(
      child: Column(
        children: [
          TextFormField(
            controller: item.name,
            decoration: InputDecoration(labelText: strings.foodName),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: item.grams,
                  decoration: InputDecoration(labelText: strings.grams),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: item.kcal,
                  decoration: const InputDecoration(labelText: 'kcal'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: item.protein,
                  decoration: const InputDecoration(labelText: 'P (g)'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: item.carbs,
                  decoration: const InputDecoration(labelText: 'C (g)'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: item.fat,
                  decoration: const InputDecoration(labelText: 'G (g)'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
