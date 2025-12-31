import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background colors - Deep purple party atmosphere
  static const Color background = Color(0xFF1A0A2E);
  static const Color surface = Color(0xFF2D1B4E);
  static const Color surfaceLight = Color(0xFF3D2B5E);

  // Primary accent colors - Warm party tones
  static const Color orange = Color(0xFFFF9500);
  static const Color gold = Color(0xFFFFD700);
  static const Color magenta = Color(0xFFE91E8C);
  static const Color purple = Color(0xFF9B59B6);

  // Legacy aliases for compatibility
  static const Color cyan = orange;
  static const Color pink = magenta;

  // Game role colors
  static const Color imposterRed = Color(0xFFE63946);
  static const Color normalGreen = Color(0xFF4CAF50);
  static const Color normalBlue = normalGreen; // Legacy alias
  static const Color winnerGold = Color(0xFFFFD700);

  // Text colors - Slightly warmer whites
  static const Color textPrimary = Color(0xFFFFF8F0);
  static const Color textSecondary = Color(0xFFCBB8D7);
  static const Color textMuted = Color(0xFF8B7A99);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE63946);
  static const Color warning = Color(0xFFFFBE21);

  // Confetti colors
  static const List<Color> confettiColors = [
    Color(0xFFFF6B9D), // Pink
    Color(0xFF5DADE2), // Blue
    Color(0xFFFFC300), // Yellow
    Color(0xFF58D68D), // Green
    Color(0xFF9B59B6), // Purple
    Color(0xFFFF9500), // Orange
  ];

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [orange, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [magenta, purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient imposterGradient = LinearGradient(
    colors: [Color(0xFFE63946), Color(0xFF8B0000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient normalGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, surfaceLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient timerGradient = LinearGradient(
    colors: [orange, magenta],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient urgentGradient = LinearGradient(
    colors: [error, Color(0xFFFF6B6B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient celebrationGradient = LinearGradient(
    colors: [gold, orange, magenta],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
