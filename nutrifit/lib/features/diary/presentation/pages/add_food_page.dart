import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/frequent_foods.dart';
import '../../domain/meal_type.dart';
import '../providers/diary_providers.dart';

/// screen3: add food to a meal slot. Frequent seed + manual form.
/// Writes through DiaryEditor, then pops (home refreshes via invalidation).
class AddFoodPage extends ConsumerStatefulWidget {
  const AddFoodPage({super.key, required this.meal});

  final MealType meal;

  @override
  ConsumerState<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends ConsumerState<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _grams = TextEditingController(text: '100');
  final _kcal = TextEditingController();
  final _protein = TextEditingController(text: '0');
  final _carbs = TextEditingController(text: '0');
  final _fat = TextEditingController(text: '0');

  @override
  void dispose() {
    _name.dispose();
    _grams.dispose();
    _kcal.dispose();
    _protein.dispose();
    _carbs.dispose();
    _fat.dispose();
    super.dispose();
  }

  double _num(TextEditingController c) => double.tryParse(c.text.trim()) ?? 0;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final day = ref.read(diaryDayProvider);
    await ref
        .read(diaryEditorProvider.notifier)
        .add(
          day: day,
          mealName: widget.meal.name,
          foodName: _name.text,
          grams: _num(_grams),
          kcal: _num(_kcal),
          protein: _num(_protein),
          carbs: _num(_carbs),
          fat: _num(_fat),
        );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final mealTitle = switch (widget.meal) {
      MealType.breakfast => strings.breakfast,
      MealType.lunch => strings.lunch,
      MealType.dinner => strings.dinner,
      MealType.snack => strings.snack,
    };
    final day = ref.watch(diaryDayProvider);
    final foods = kFrequentFoods
        .where((f) => f.meals.contains(widget.meal))
        .toList();
    final editor = ref.watch(diaryEditorProvider);

    return Scaffold(
      appBar: AppBar(title: Text('${strings.addToMeal} · $mealTitle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${strings.frequentInMeal} · $mealTitle',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final food in foods)
            AppCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '${food.portion} · ${food.kcal.toStringAsFixed(0)} kcal',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'P: ${food.protein}g · C: ${food.carbs}g · G: ${food.fat}g',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: editor.isLoading
                        ? null
                        : () async {
                            await ref
                                .read(diaryEditorProvider.notifier)
                                .add(
                                  day: day,
                                  mealName: widget.meal.name,
                                  foodName: food.name,
                                  grams: 100,
                                  kcal: food.kcal,
                                  protein: food.protein,
                                  carbs: food.carbs,
                                  fat: food.fat,
                                );
                            if (context.mounted) context.pop();
                          },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(
            strings.manualEntry,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          AppCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(labelText: strings.foodName),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '!' : null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _grams,
                          decoration: InputDecoration(
                            labelText: strings.grams,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _kcal,
                          decoration: const InputDecoration(labelText: 'kcal'),
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? '!' : null,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _protein,
                          decoration: const InputDecoration(labelText: 'P (g)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _carbs,
                          decoration: const InputDecoration(labelText: 'C (g)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _fat,
                          decoration: const InputDecoration(labelText: 'G (g)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: editor.isLoading ? null : _save,
                    child: Text(strings.save),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppCard(child: Text(strings.tipScale)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/scan'),
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(strings.scanFood),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              ymd(day),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
