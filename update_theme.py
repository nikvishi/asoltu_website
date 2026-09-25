import re
with open('lib/core/theme/theme_manager.dart', 'r') as f:
    code = f.read()

# Update ThemeHelper colors for a better Vercel/Linear look
new_theme = """
extension ThemeHelper on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get bgCanvas => isDark ? const Color(0xFF09090B) : const Color(0xFFFAFAFA);
  Color get bgCard => isDark ? const Color(0xFF18181B) : Colors.white;
  Color get textPrimary => isDark ? const Color(0xFFFAFAFA) : const Color(0xFF09090B);
  Color get textSecondary => isDark ? const Color(0xFFA1A1AA) : const Color(0xFF71717A);
  Color get border => isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1);
  Color get primaryAccent => isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
}
"""

code = re.sub(r'extension ThemeHelper on BuildContext \{[\s\S]*?\}', new_theme.strip(), code)

with open('lib/core/theme/theme_manager.dart', 'w') as f:
    f.write(code)
