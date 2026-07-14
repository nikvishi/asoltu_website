import 'package:flutter/material.dart';

/// ASOLTU Phase 4.2 marketing brand tokens.
abstract final class AppColors {
  AppColors._();

  // Brand — Phase 4.2
  static const Color brandNavy = Color(0xFF0D1B5E);
  static const Color brandNavyLight = Color(0xFF1A2F7A);
  static const Color brandNavyDark = Color(0xFF08123F);

  static const Color accentBlue = Color(0xFF1E5EFF);
  static const Color accentBlueLight = Color(0xFF4B7CFF);
  static const Color accentBlueDark = Color(0xFF1647C9);

  static const Color accentGold = Color(0xFFF5B21A);
  static const Color accentGoldLight = Color(0xFFF7C44A);
  static const Color accentGoldDark = Color(0xFFD4960E);

  // Surfaces
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF5F7FB);
  static const Color surfaceSoft = Color(0xFFF0F3FA);
  static const Color borderLight = Color(0xFFE6EAF2);

  // Dark (optional chrome)
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color surfaceDark = Color(0xFF151D2B);
  static const Color surfaceHighDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF2A3548);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  // Slightly darker muted for AA-friendly secondary chrome on white surfaces.
  static const Color textMuted = Color(0xFF64748B);
  static const Color textOnNavy = Color(0xFFFFFFFF);
  static const Color textOnGold = Color(0xFF0F172A);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = accentBlue;

  // Legacy aliases (header/footer compatibility)
  static const Color brandNavyLegacy = brandNavy;

  static const LinearGradient navyHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandNavyDark, brandNavy, Color(0xFF142A70)],
  );

  static const LinearGradient blueAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentBlueDark, accentBlue, accentBlueLight],
  );

  static const LinearGradient goldAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGoldDark, accentGold, accentGoldLight],
  );
}
