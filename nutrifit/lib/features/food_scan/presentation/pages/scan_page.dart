import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/food_estimate.dart';
import '../../domain/food_estimate_mapper.dart';
import '../providers/scan_providers.dart';
import '../widgets/scan_results.dart';

/// Pick a photo (camera or gallery) and let the AI estimate its nutrients.
class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  Uint8List? _imageBytes;
  String _mimeType = 'image/jpeg';
  bool _isPicking = false;
  String? _pickError;

  Future<void> _pick(ImageSource source) async {
    setState(() {
      _isPicking = true;
      _pickError = null;
    });
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1280,
        imageQuality: 85,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        setState(() => _pickError = 'empty-image');
        return;
      }
      if (!mounted) return;
      setState(() {
        _imageBytes = bytes;
        _mimeType = file.mimeType ?? 'image/jpeg';
        ref.read(scanControllerProvider.notifier).reset();
      });
    } catch (_) {
      if (mounted) setState(() => _pickError = 'pick-failed');
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  Future<void> _analyze() async {
    final bytes = _imageBytes;
    if (bytes == null) return;
    await ref
        .read(scanControllerProvider.notifier)
        .analyze(imageBytes: bytes, mimeType: _mimeType);
  }

  void _goToConfirm(List<FoodEstimate> estimates) {
    context.push(
      '/scan/confirm',
      extra: estimates.map((e) => e.toItem()).toList(),
    );
  }

  /// Friendly message depending on the failure cause.
  String _errorMessage(Object? error, AppStrings strings) {
    if (error is Failure) {
      if (error.message == 'no-gemini-key') return strings.missingAiKey;
      if (error.message == 'empty-result') return strings.noFoodDetected;
    }
    return strings.scanError;
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final scanState = ref.watch(scanControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(strings.scanTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_imageBytes == null)
            AppCard(
              child: Column(
                children: [
                  Icon(
                    Icons.photo_camera_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    strings.scanHint,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: strings.takePhoto,
                    onPressed: _isPicking
                        ? null
                        : () => _pick(ImageSource.camera),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _isPicking
                        ? null
                        : () => _pick(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text(strings.pickFromGallery),
                  ),
                  if (_pickError != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      strings.scanError,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(_imageBytes!, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _imageBytes = null;
                      ref.read(scanControllerProvider.notifier).reset();
                    }),
                    icon: const Icon(Icons.refresh),
                    label: Text(strings.retakePhoto),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: scanState.isLoading ? null : _analyze,
                    icon: const Icon(Icons.auto_awesome),
                    label: Text(strings.analyze),
                  ),
                ),
              ],
            ),
          ],
          if (scanState.isLoading) ...[
            const SizedBox(height: 24),
            AppLoader(label: strings.analyzing),
          ],
          if (scanState.hasError) ...[
            const SizedBox(height: 16),
            AppErrorView(
              message: _errorMessage(scanState.error, strings),
              retryLabel: strings.retry,
              onRetry: _analyze,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.push('/add-food/snack'),
              child: Text(strings.addManually),
            ),
          ],
          if (scanState.hasValue) ...[
            const SizedBox(height: 16),
            ScanResults(
              estimates: scanState.requireValue,
              title: strings.detectedFoods,
              actionLabel: strings.addToDiary,
              onAddToDiary: () => _goToConfirm(scanState.requireValue),
            ),
          ],
        ],
      ),
    );
  }
}
