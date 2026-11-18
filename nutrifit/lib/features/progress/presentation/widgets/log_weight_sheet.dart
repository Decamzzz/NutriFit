import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/body_metrics.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/weight_providers.dart';

/// Opens the "log a new weight" bottom sheet.
Future<void> showLogWeightSheet(BuildContext context, {double? initialKg}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => LogWeightSheet(initialKg: initialKg),
  );
}

/// Weight + date form. One weight per day: logging the same day replaces it.
class LogWeightSheet extends ConsumerStatefulWidget {
  const LogWeightSheet({super.key, this.initialKg});

  final double? initialKg;

  @override
  ConsumerState<LogWeightSheet> createState() => _LogWeightSheetState();
}

class _LogWeightSheetState extends ConsumerState<LogWeightSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _weight = TextEditingController(
    text: widget.initialKg?.toStringAsFixed(1) ?? '',
  );
  DateTime _day = startOfDay(DateTime.now());
  bool _failed = false;

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(2000),
      lastDate: startOfDay(DateTime.now()),
    );
    if (picked != null && mounted) setState(() => _day = startOfDay(picked));
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final kg = roundToTenth(parseDecimal(_weight.text)!);
    final messenger = ScaffoldMessenger.of(context);
    final savedText = ref.read(stringsProvider).weightSaved;
    await ref.read(weightEditorProvider.notifier).save(day: _day, weightKg: kg);
    if (!mounted) return;
    if (ref.read(weightEditorProvider).hasError) {
      setState(() => _failed = true);
      return;
    }
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(content: Text(savedText), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final saving = ref.watch(weightEditorProvider).isLoading;
    final l10n = MaterialLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.logWeight,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _weight,
              autofocus: true,
              decoration: InputDecoration(
                labelText: strings.weight,
                suffixText: 'kg',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              validator: (v) => isValidWeightKg(parseDecimal(v ?? ''))
                  ? null
                  : strings.invalidWeight,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(strings.date),
              trailing: Text(l10n.formatMediumDate(_day)),
              onTap: _pickDate,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: strings.save,
              onPressed: saving ? null : _save,
            ),
            if (_failed)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  strings.weightSaveError,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
