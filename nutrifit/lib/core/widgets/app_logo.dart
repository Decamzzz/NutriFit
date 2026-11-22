import 'package:flutter/material.dart';

/// NutriFit brand logo (`assets/images/logo.jpg`).
///
/// Kept in `core` so any feature can reuse it without importing another
/// feature.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 160});

  final double height;

  static const String assetPath = 'assets/images/logo.jpg';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        assetPath,
        height: height,
        fit: BoxFit.contain,
        semanticLabel: 'NutriFit',
      ),
    );
  }
}
