import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/breakpoints.dart';
import '../../data/products.dart';
import '../../routing/route_names.dart';
import '../../theme/theme_manager.dart';
import '../components/book_demo_dialog.dart';
import '../components/brand_logo.dart';
import '../components/product_icon.dart';

class _NavItem {
  const _NavItem(this.label, this.route, {this.megaMenu = false});
  final String label;
  final String route;

  /// Opens the product panel on hover instead of navigating on hover.
  final bool megaMenu;
}

const _primaryNav = [
  _NavItem('Products', '/software', megaMenu: true),
  _NavItem('Downloads', AppRoutes.downloads),
  _NavItem('Education', '/education'),
  _NavItem('Support', AppRoutes.support),
  _NavItem('About', AppRoutes.about),
];

/// Sticky glass header.
///
/// The bar is transparent over the top of the page and fades in its glass
/// background once the visitor scrolls, so the hero screenshot is never cut by
/// a hard bar. [scrolled] is driven by [SiteScaffold].
class SiteHeader extends StatefulWidget {
  const SiteHeader({super.key, this.onOpenMenu, this.scrolled = false});

  final VoidCallback? onOpenMenu;
  final bool scrolled;

  static const double height = 68;

  @override
  State<SiteHeader> createState() => _SiteHeaderState();
}

class _SiteHeaderState extends State<SiteHeader> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _menu;
  bool _pointerInMenu = false;
  bool _pointerInTrigger = false;

  @override
  void dispose() {
    _menu?.remove();
    _menu = null;
    super.dispose();
  }

  void _openMenu() {
    if (_menu != null) return;
    _menu = OverlayEntry(
      builder: (_) => Positioned(
        width: 720,
        child: CompositedTransformFollower(
          link: _link,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(-24, 10),
          child: MouseRegion(
            onEnter: (_) => _pointerInMenu = true,
            onExit: (_) {
              _pointerInMenu = false;
              _maybeCloseMenu();
            },
            child: _ProductMegaMenu(onNavigate: _closeMenu),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_menu!);
  }

  void _closeMenu() {
    _menu?.remove();
    _menu = null;
  }

  /// Lets the pointer cross the gap between the trigger and the panel without
  /// the panel snapping shut underneath it.
  void _maybeCloseMenu() {
    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      if (!_pointerInMenu && !_pointerInTrigger) _closeMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= Breakpoints.tablet;
    final location = GoRouterState.of(context).uri.path;
    final scrolled = widget.scrolled;

    return ClipRect(
      child: RepaintBoundary(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: SiteHeader.height,
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 28 : 18),
          decoration: BoxDecoration(
            color: scrolled
                ? (context.isDark
                      ? const Color(0xFF0A0A1B).withValues(alpha: 0.94)
                      : Colors.white.withValues(alpha: 0.94))
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: scrolled ? context.border : Colors.transparent,
              ),
            ),
          ),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.go(AppRoutes.home),
                  child: const BrandLogo(height: 30),
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(width: 36),
                CompositedTransformTarget(
                  link: _link,
                  child: Row(
                    children: [
                      for (final item in _primaryNav)
                        _NavLink(
                          label: item.label,
                          selected: item.route == AppRoutes.home
                              ? location == item.route
                              : location.startsWith(item.route),
                          hasMenu: item.megaMenu,
                          onTap: () {
                            _closeMenu();
                            context.go(item.route);
                          },
                          onHover: (hovering) {
                            if (!item.megaMenu) {
                              if (hovering) _closeMenu();
                              return;
                            }
                            _pointerInTrigger = hovering;
                            if (hovering) {
                              _openMenu();
                            } else {
                              _maybeCloseMenu();
                            }
                          },
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                const _ThemeToggle(),
                const SizedBox(width: 6),
                _GhostButton(
                  label: 'Login',
                  onTap: () => context.go(AppRoutes.login),
                ),
                const SizedBox(width: 10),
                _AccentButton(
                  label: 'Book Demo',
                  onTap: () => showBookDemoDialog(context),
                ),
              ] else ...[
                const Spacer(),
                const _ThemeToggle(),
                IconButton(
                  tooltip: 'Open menu',
                  onPressed: widget.onOpenMenu,
                  icon: Icon(Icons.menu_rounded, color: context.textPrimary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Nav link with an accent underline that grows from the centre on hover.
class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.onTap,
    required this.onHover,
    this.selected = false,
    this.hasMenu = false,
  });

  final String label;
  final VoidCallback onTap;
  final ValueChanged<bool> onHover;
  final bool selected;
  final bool hasMenu;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
        widget.onHover(true);
      },
      onExit: (_) {
        setState(() => _hovered = false);
        widget.onHover(false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                      color: active
                          ? context.textPrimary
                          : context.textSecondary,
                    ),
                  ),
                  if (widget.hasMenu) ...[
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 180),
                      turns: _hovered ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: active
                            ? context.textPrimary
                            : context.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 2,
                width: active ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: context.accentGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Hover panel listing every product with its real app icon.
class _ProductMegaMenu extends StatelessWidget {
  const _ProductMegaMenu({required this.onNavigate});

  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: context.border),
          boxShadow: context.shadowLifted,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MenuSectionLabel('Desktop apps'),
            const SizedBox(height: 8),
            _MenuGrid(products: desktopProducts, onNavigate: onNavigate),
            const SizedBox(height: 16),
            _MenuSectionLabel('Mobile apps'),
            const SizedBox(height: 8),
            _MenuGrid(products: mobileProducts, onNavigate: onNavigate),
            const SizedBox(height: 14),
            Divider(height: 1, color: context.border),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.download_rounded,
                    size: 17,
                    color: context.primaryAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'All downloads in one place',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        onNavigate();
                        context.go(AppRoutes.downloads);
                      },
                      child: Text(
                        'Download Center →',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: context.primaryAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuSectionLabel extends StatelessWidget {
  const _MenuSectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: context.textMuted,
        ),
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({required this.products, required this.onNavigate});

  final List<Product> products;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final p in products)
          SizedBox(
            width: 340,
            child: _MenuRow(product: p, onNavigate: onNavigate),
          ),
      ],
    );
  }
}

class _MenuRow extends StatefulWidget {
  const _MenuRow({required this.product, required this.onNavigate});

  final Product product;
  final VoidCallback onNavigate;

  @override
  State<_MenuRow> createState() => _MenuRowState();
}

class _MenuRowState extends State<_MenuRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          widget.onNavigate();
          context.go(p.route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered ? context.bgGlass : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ProductIcon(product: p, size: 40, glow: _hovered),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: context.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return IconButton(
      tooltip: isDark ? 'Switch to light' : 'Switch to dark',
      onPressed: ThemeManager.toggleTheme,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: Tween(begin: 0.7, end: 1.0).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
          size: 20,
          color: context.textSecondary,
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  const _GhostButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? context.bgGlass : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
              color: context.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _AccentButton extends StatefulWidget {
  const _AccentButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_AccentButton> createState() => _AccentButtonState();
}

class _AccentButtonState extends State<_AccentButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            gradient: context.accentGradient,
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: context.primaryAccent.withValues(
                  alpha: _hovered ? 0.42 : 0.24,
                ),
                blurRadius: _hovered ? 22 : 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Text(
            'Book Demo',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile navigation, with the same product list the desktop panel shows.
class SiteMobileDrawer extends StatelessWidget {
  const SiteMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: context.bgCanvas,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BrandLogo(height: 34),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: context.textMuted),
                  ),
                ],
              ),
            ),
            for (final item in _primaryNav)
              ListTile(
                title: Text(
                  item.label,
                  style: TextStyle(
                    color: location.startsWith(item.route)
                        ? context.primaryAccent
                        : context.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(item.route);
                },
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: _MenuSectionLabel('Apps'),
            ),
            for (final p in kProducts)
              ListTile(
                leading: ProductIcon(product: p, size: 34, glow: false),
                title: Text(
                  p.name,
                  style: TextStyle(
                    color: context.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  p.tagline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: context.textMuted, fontSize: 12.5),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(p.route);
                },
              ),
          ],
        ),
      ),
    );
  }
}
