import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/models/user_settings.dart';
import '../../../../core/providers/user_settings_provider.dart';
import '../../../../core/utils/body_metrics.dart';
import '../../../../core/widgets/app_card.dart';
import 'number_input_dialog.dart';

/// Profile card with the body data the user can edit: height and goal weight.
class BodyDataCard extends ConsumerWidget {
  const BodyDataCard({super.key, required this.settings});

  final UserSettings settings;

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String errorText,
    required bool Function(double) isValid,
    required double? initial,
    required Future<void> Function(UserSettingsEditor editor, double value)
    save,
  }) async {
    final value = await showNumberInputDialog(
      context,
      title: title,
      errorText: errorText,
      isValid: isValid,
      initial: initial,
    );
    if (value == null) return;
    await save(ref.read(userSettingsEditorProvider.notifier), value);
    if (!context.mounted) return;
    final strings = ref.read(stringsProvider);
    final failed = ref.read(userSettingsEditorProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failed ? strings.settingsSaveError : strings.saved),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final height = settings.heightCm;
    final goalWeight = settings.goalWeightKg;

    return AppCard(
      child: Column(
        children: [
          _BodyRow(
            label: strings.height,
            value: height == null ? strings.notSet : '${height.toStringAsFixed(1)} cm',
            onTap: () => _edit(
              context,
              ref,
              title: strings.height,
              errorText: strings.invalidHeight,
              isValid: isValidHeightCm,
              initial: height,
              save: (editor, v) => editor.saveBodyData(heightCm: v),
            ),
          ),
          const Divider(),
          _BodyRow(
            label: strings.goalWeight,
            value: goalWeight == null ? strings.notSet : strings.kgValue(goalWeight),
            onTap: () => _edit(
              context,
              ref,
              title: strings.goalWeight,
              errorText: strings.invalidGoalWeight,
              isValid: isValidWeightKg,
              initial: goalWeight,
              save: (editor, v) => editor.saveBodyData(goalWeightKg: v),
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyRow extends StatelessWidget {
  const _BodyRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.labelLarge),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}
