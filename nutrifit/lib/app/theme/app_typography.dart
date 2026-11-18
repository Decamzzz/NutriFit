import 'package:flutter/material.dart';

/// Centralized text styles. Widgets must use these instead of ad-hoc styles.
abstract final class AppTypography {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle body = TextStyle(fontSize: 14, height: 1.45);
  static const TextStyle bodySmall = TextStyle(fontSize: 12, height: 1.4);
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
}
