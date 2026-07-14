import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_urls.dart';
import '../../constants/breakpoints.dart';
import '../../routing/route_names.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../components/asoltu_button.dart';
import '../components/book_demo_dialog.dart';
import '../components/brand_logo.dart';
import 'max_width_container.dart';

class _NavItem {
  const _NavItem(this.label, this.route);
  final String label;
  final String route;
}

const _primaryNav = [
  _NavItem('Products', AppRoutes.products),
  _NavItem('Solutions', AppRoutes.solutions),
  _NavItem('Pricing', AppRoutes.pricing),
  _NavItem('Resources', AppRoutes.resources),
  _NavItem('About', AppRoutes.about),
  _NavItem('Contact', AppRoutes.contact),
];

/// Sticky marketing header with desktop nav + mobile drawer trigger.
class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key, this.onOpenMenu});

  final VoidCallback? onOpenMenu;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= Breakpoints.tablet;
    final location = GoRouterState.of(context).uri.path;

    return Material(
      color: AppColors.surfaceLight.withValues(alpha: 0.96),
      elevation: 0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderLight)),
        ),
        child: SizedBox(
          height: 72,
          child: MaxWidthContainer(
            padding: EdgeInsets.symmetric(
              horizontal: width >= Breakpoints.desktop
                  ? AppSpacing.pageXDesktop
                  : AppSpacing.pageX,
            ),
            child: Row(
              children: [
                const BrandLogo(height: 36),
                if (isDesktop) ...[
                  const SizedBox(width: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final item in _primaryNav)
                            _NavLink(
                              label: item.label,
                              selected: location == item.route ||
                                  (item.route != AppRoutes.home &&
                                      location.startsWith(item.route)),
                              onTap: () => context.go(item.route),
                            ),
                        ],
                      ),
                    ),
                  ),
                  AsoltuButton(
                    label: 'Book Demo',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => showBookDemoDialog(context),
                  ),
                  const SizedBox(width: 8),
                  AsoltuButton(
                    label: 'Login',
                    variant: AsoltuButtonVariant.ghost,
                    onPressed: () => context.go(AppRoutes.login),
                  ),
                  const SizedBox(width: 8),
                  AsoltuButton(
                    label: 'Open ERP',
                    variant: AsoltuButtonVariant.primary,
                    icon: Icons.open_in_new_rounded,
                    onPressed: () => launchUrl(
                      Uri.parse(AppUrls.erpPortal),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                  IconButton(
                    tooltip: 'Open menu',
                    onPressed: onOpenMenu,
                    iconSize: 28,
                    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    icon: const Icon(Icons.menu_rounded),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hovered;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Semantics(
        button: true,
        selected: widget.selected,
        label: widget.label,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(8),
            focusColor: AppColors.accentBlue.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                  color: active ? AppColors.brandNavy : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Drawer content for mobile navigation.
class SiteMobileDrawer extends StatelessWidget {
  const SiteMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: BrandLogo(height: 40),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  for (final item in _primaryNav)
                    ListTile(
                      title: Text(item.label),
                      selected: location == item.route,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(item.route);
                      },
                    ),
                  ListTile(
                    title: const Text('Blog'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go(AppRoutes.blog);
                    },
                  ),
                  ListTile(
                    title: const Text('Careers'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go(AppRoutes.careers);
                    },
                  ),
                  ListTile(
                    title: const Text('Support'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go(AppRoutes.support);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AsoltuButton(
                    label: 'Book Demo',
                    expanded: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showBookDemoDialog(context);
                    },
                  ),
                  const SizedBox(height: 8),
                  AsoltuButton(
                    label: 'Login to ERP',
                    variant: AsoltuButtonVariant.secondary,
                    expanded: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(AppRoutes.login);
                    },
                  ),
                  const SizedBox(height: 8),
                  AsoltuButton(
                    label: 'Open ERP Portal',
                    variant: AsoltuButtonVariant.secondary,
                    expanded: true,
                    onPressed: () => launchUrl(
                      Uri.parse(AppUrls.erpPortal),
                      mode: LaunchMode.externalApplication,
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
