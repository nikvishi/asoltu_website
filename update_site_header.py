import re

with open('lib/core/widgets/layout/site_header.dart', 'r') as f:
    content = f.read()

# Add import for theme manager
content = content.replace(
    "import 'package:go_router/go_router.dart';",
    "import 'package:go_router/go_router.dart';\nimport '../../theme/theme_manager.dart';"
)

# Add toggle button to desktop nav
desktop_buttons = r"AsoltuButton\(\s*label: 'Book Demo',"
desktop_toggle = r"""IconButton(
                    tooltip: 'Toggle Theme',
                    onPressed: () => ThemeManager.toggleTheme(),
                    icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
                  ),
                  const SizedBox(width: 8),
                  AsoltuButton(
                    label: 'Book Demo',"""

content = re.sub(desktop_buttons, desktop_toggle, content)

# Add toggle button to mobile drawer nav
mobile_drawer_header = r"const Padding\(\s*padding: EdgeInsets.all\(20\),\s*child: BrandLogo\(height: 40\),\s*\),"
mobile_drawer_header_new = r"""Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BrandLogo(height: 40),
                  IconButton(
                    onPressed: () => ThemeManager.toggleTheme(),
                    icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
                  ),
                ],
              ),
            ),"""

content = re.sub(mobile_drawer_header, mobile_drawer_header_new, content)

with open('lib/core/widgets/layout/site_header.dart', 'w') as f:
    f.write(content)
