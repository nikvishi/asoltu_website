import 'package:flutter/material.dart';

class ThemeManager {
  /// Light is the default first impression; the header toggle switches to the
  /// dark palette, which is fully designed rather than a fallback.
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(ThemeMode.light);

  static void toggleTheme() {
    themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}

/// Design tokens for the marketing site.
///
/// The canvas is a deep indigo rather than near-black, and every surface sits
/// a step above it with a visible tint — flat black read as empty rather than
/// premium. ASOLTU gold returns as the highlight colour next to the blue.
///
/// Pages must not hardcode colours; add a token here instead.
extension ThemeHelper on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // --- Canvas & surfaces -------------------------------------------------
  Color get bgCanvas =>
      isDark ? const Color(0xFF0A0A1B) : const Color(0xFFFBFAFF);

  /// Alternating band, one step off the canvas.
  Color get bgSubtle =>
      isDark ? const Color(0xFF0E0E24) : const Color(0xFFF3F2FC);

  Color get bgCard =>
      isDark ? const Color(0xFF16162E) : Colors.white;

  Color get bgCardRaised =>
      isDark ? const Color(0xFF1D1D3A) : Colors.white;

  /// Translucent fill for glass chrome (header, chips, pills).
  Color get bgGlass => isDark
      ? Colors.white.withValues(alpha: 0.06)
      : Colors.white.withValues(alpha: 0.62);

  // --- Text --------------------------------------------------------------
  Color get textPrimary =>
      isDark ? const Color(0xFFF6F6FF) : const Color(0xFF120E2E);
  Color get textSecondary =>
      isDark ? const Color(0xFFAFAFD0) : const Color(0xFF585272);
  Color get textMuted =>
      isDark ? const Color(0xFF7A7AA0) : const Color(0xFF8B85A8);

  // --- Borders -----------------------------------------------------------
  Color get border => isDark
      ? Colors.white.withValues(alpha: 0.10)
      : const Color(0xFF120E2E).withValues(alpha: 0.09);
  Color get borderStrong => isDark
      ? Colors.white.withValues(alpha: 0.20)
      : const Color(0xFF120E2E).withValues(alpha: 0.16);

  // --- Accents -----------------------------------------------------------
  Color get primaryAccent =>
      isDark ? const Color(0xFF6E8BFF) : const Color(0xFF3A5BF5);

  /// ASOLTU gold, for badges, highlights and the second half of gradients.
  Color get goldAccent =>
      isDark ? const Color(0xFFFFC94D) : const Color(0xFFE09A00);

  Color get violetAccent =>
      isDark ? const Color(0xFFA07CFF) : const Color(0xFF7B4DF0);

  Color get accentSoft => primaryAccent.withValues(alpha: isDark ? 0.20 : 0.12);
  Color get goldSoft => goldAccent.withValues(alpha: isDark ? 0.18 : 0.16);

  LinearGradient get accentGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF5B7CFF), Color(0xFF9B5CFF)]
            : const [Color(0xFF3A5BF5), Color(0xFF7B3DF0)],
      );

  /// Blue into gold — the brand pairing, used on headline words and hero art.
  LinearGradient get brandGradient => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? const [Color(0xFF7DA0FF), Color(0xFFB98CFF), Color(0xFFFFC94D)]
            : const [Color(0xFF3A5BF5), Color(0xFF7B3DF0), Color(0xFFE09A00)],
      );

  // --- Elevation ---------------------------------------------------------
  List<BoxShadow> get shadowCard => isDark
      ? const [
          BoxShadow(
              color: Color(0x59000022), blurRadius: 20, offset: Offset(0, 8)),
        ]
      : const [
          BoxShadow(
              color: Color(0x14120E2E), blurRadius: 20, offset: Offset(0, 8)),
          BoxShadow(
              color: Color(0x0A120E2E), blurRadius: 4, offset: Offset(0, 1)),
        ];

  List<BoxShadow> get shadowLifted => isDark
      ? [
          const BoxShadow(
              color: Color(0x8C000022), blurRadius: 30, offset: Offset(0, 14)),
          BoxShadow(
              color: violetAccent.withValues(alpha: 0.28),
              blurRadius: 36,
              spreadRadius: -10),
        ]
      : [
          const BoxShadow(
              color: Color(0x28120E2E), blurRadius: 30, offset: Offset(0, 14)),
          BoxShadow(
              color: violetAccent.withValues(alpha: 0.20),
              blurRadius: 44,
              spreadRadius: -10),
        ];

  /// Deep shadow for hero art so it lifts off the canvas.
  List<BoxShadow> get shadowScreenshot => isDark
      ? [
          const BoxShadow(
              color: Color(0xB3000022), blurRadius: 48, offset: Offset(0, 24)),
          BoxShadow(
              color: violetAccent.withValues(alpha: 0.34),
              blurRadius: 64,
              spreadRadius: -18),
        ]
      : [
          const BoxShadow(
              color: Color(0x33120E2E), blurRadius: 44, offset: Offset(0, 22)),
          BoxShadow(
              color: violetAccent.withValues(alpha: 0.24),
              blurRadius: 56,
              spreadRadius: -16),
        ];
}
