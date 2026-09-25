import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Bundled in pubspec under `fonts:`. Previously pulled from Google at
/// runtime, which delayed first paint on every visit.
const String _fontFamily = 'PlusJakartaSans';

/// Poppins type scale for Phase 4.2 marketing site.
abstract final class AppTypography {
  AppTypography._();

  static TextTheme textTheme({required bool dark}) {
    final base =
        dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
    final primary = dark ? AppColors.textOnNavy : AppColors.textPrimary;
    final secondary = dark ? AppColors.textMuted : AppColors.textSecondary;

    return base.apply(fontFamily: _fontFamily).copyWith(
      displayLarge: TextStyle(fontFamily: _fontFamily, 
        fontSize: 56,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        height: 1.08,
        color: primary,
      ),
      displayMedium: TextStyle(fontFamily: _fontFamily, 
        fontSize: 44,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.12,
        color: primary,
      ),
      displaySmall: TextStyle(fontFamily: _fontFamily, 
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.18,
        color: primary,
      ),
      headlineLarge: TextStyle(fontFamily: _fontFamily, 
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      headlineMedium: TextStyle(fontFamily: _fontFamily, 
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineSmall: TextStyle(fontFamily: _fontFamily, 
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: TextStyle(fontFamily: _fontFamily, 
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: TextStyle(fontFamily: _fontFamily, 
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleSmall: TextStyle(fontFamily: _fontFamily, 
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: TextStyle(fontFamily: _fontFamily, 
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.65,
        color: secondary,
      ),
      bodyMedium: TextStyle(fontFamily: _fontFamily, 
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: secondary,
      ),
      bodySmall: TextStyle(fontFamily: _fontFamily, 
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: secondary,
      ),
      labelLarge: TextStyle(fontFamily: _fontFamily, 
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      labelMedium: TextStyle(fontFamily: _fontFamily, 
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: secondary,
      ),
    );
  }
}
