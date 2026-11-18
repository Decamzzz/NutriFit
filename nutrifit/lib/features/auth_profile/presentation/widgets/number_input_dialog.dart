import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/body_metrics.dart';

/// Asks for a single decimal number. Returns it, or null when cancelled.
/// The dialog stays open (with [errorText]) while the value is not valid.
Future<double?> showNumberInputDialog(
  BuildContext context, {
  required String title,
  required String errorText,
  required bool Function(double value) isValid,
  double? initial,
}) {
  return showDialog<double>(
    context: context,
    builder: (_) => _NumberInputDialog(
      title: title,
      errorText: errorText,
      isValid: isValid,
      initial: initial,
    ),
  );
}

class _NumberInputDialog extends ConsumerStatefulWidget {
  const _NumberInputDialog({
    required this.title,
    required this.errorText,
    required this.isValid,
    this.initial,
  });

  final String title;
  final String errorText;
  final bool Function(double value) isValid;
  final double? initial;

  @override
  ConsumerState<_NumberInputDialog> createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends ConsumerState<_NumberInputDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial == null ? '' : widget.initial!.toStringAsFixed(1),
  );
  bool _invalid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = parseDecimal(_controller.text);
    if (value == null || !widget.isValid(value)) {
      setState(() => _invalid = true);
      return;
    }
    Navigator.pop(context, roundToTenth(value));
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
        decoration: InputDecoration(
          errorText: _invalid ? widget.errorText : null,
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(strings.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(strings.save)),
      ],
    );
  }
}
