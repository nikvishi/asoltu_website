with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

import re
bg_code = """
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.bgCanvas,
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
            context.isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : const Color(0xFFF1F5F9),
            context.bgCanvas,
          ],
        )
      ),
      child: Stack(
"""

code = code.replace("""
    return Container(
      width: double.infinity,
      color: context.bgCanvas,
      child: Stack(
""", bg_code.strip() + "\n")

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
