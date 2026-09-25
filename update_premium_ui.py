import re

with open('lib/features/products/presentation/product_landing_template.dart', 'r') as f:
    content = f.read()

# Add flutter_animate import
content = content.replace(
    "import 'dart:ui';",
    "import 'dart:ui';\nimport 'package:flutter_animate/flutter_animate.dart';"
)

# Fix Mobile padding
content = content.replace(
    "padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),",
    "padding: EdgeInsets.symmetric(horizontal: 24, vertical: MediaQuery.of(context).size.width > 600 ? 120 : 60),"
)

# Fix Mobile font size
content = content.replace(
    "style: Theme.of(context).textTheme.displayMedium?.copyWith(",
    "style: Theme.of(context).textTheme.displayMedium?.copyWith(\n                        fontSize: MediaQuery.of(context).size.width < 600 ? 36 : null,"
)

# Fix Feature Card width for mobile
content = content.replace(
    "width: 340, // slightly wider",
    "width: MediaQuery.of(context).size.width < 600 ? double.infinity : 340,"
)

# Add staggering animations to Hero content
content = content.replace(
    "MaxWidthContainer(",
    "MaxWidthContainer("
)

# Let's wrap the Column in MaxWidthContainer with .animate().fade().slideY()
hero_column_pattern = r"(MaxWidthContainer\(\s*child:\s*Column\(\s*children:\s*\[\s*// Glassmorphism icon container)(.*?)(\],\s*\),\s*\),)"

replacement = r"""\1\2\3.animate(interval: 100.ms).fade(duration: 800.ms, curve: Curves.easeOut).slideY(begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOut)"""

content = re.sub(hero_column_pattern, replacement, content, flags=re.DOTALL)

with open('lib/features/products/presentation/product_landing_template.dart', 'w') as f:
    f.write(content)

