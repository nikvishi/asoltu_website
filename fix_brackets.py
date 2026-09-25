with open('lib/core/widgets/layout/site_header.dart', 'r') as f:
    code = f.read()

import re

# Find the build method
start_idx = code.find('Widget build(BuildContext context) {')
end_idx = code.find('class _NavLink extends')

build_method = """Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= Breakpoints.tablet;
    final location = GoRouterState.of(context).uri.path;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 64,
                constraints: BoxConstraints(maxWidth: Breakpoints.desktop),
                margin: EdgeInsets.symmetric(horizontal: width < Breakpoints.tablet ? 16 : 32),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05), width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 30, offset: const Offset(0, 10))
                  ]
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const BrandLogo(height: 32),
                    if (isDesktop) ...[
                      const Spacer(),
                      for (final item in _primaryNav)
                        _NavLink(
                          label: item.label,
                          selected: location == item.route || (item.route != AppRoutes.home && location.startsWith(item.route)),
                          onTap: () => context.go(item.route),
                          isDark: isDark,
                        ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Toggle Theme',
                        onPressed: () => ThemeManager.toggleTheme(),
                        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.white : Colors.black87),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => context.go(AppRoutes.login),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                          child: Text('Login', style: TextStyle(fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => showBookDemoDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF4F46E5)]),
                          ),
                          child: const Text('Book Demo', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                        ),
                      ),
                    ] else ...[
                      const Spacer(),
                      IconButton(
                        tooltip: 'Open menu',
                        onPressed: onOpenMenu,
                        icon: Icon(Icons.menu_rounded, color: isDark ? Colors.white : Colors.black87),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

"""
new_code = code[:start_idx] + build_method + code[end_idx:]

with open('lib/core/widgets/layout/site_header.dart', 'w') as f:
    f.write(new_code)
