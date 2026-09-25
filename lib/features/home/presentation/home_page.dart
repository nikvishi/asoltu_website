import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/data/products.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/widgets/components/aurora_background.dart';
import '../../../core/widgets/layout/max_width_container.dart';
import '../../../core/widgets/layout/site_header.dart';
import 'widgets/featured_app.dart';
import 'widgets/product_grid.dart';
import 'widgets/reveal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Each band is its own raster layer: without these the whole page
    // repainted on every scroll frame.
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RepaintBoundary(child: _HeroSection()),
        RepaintBoundary(child: _ProductsSection()),
        RepaintBoundary(child: _WhySection()),
        RepaintBoundary(child: _CtaSection()),
      ],
    );
  }
}

/// Hero: the promise, then a named app the visitor can install right now.
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static final Product _featured = productById('datahop') ?? kProducts.first;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < Breakpoints.mobile;
    final isTablet = width < Breakpoints.tablet;
    final titleSize = (isMobile ? 36 : (isTablet ? 52 : 64)).toDouble();

    final titleStyle = TextStyle(
      fontSize: titleSize,
      height: 1.06,
      fontWeight: FontWeight.w800,
      letterSpacing: isMobile ? -1.2 : -2.2,
    );

    return Container(
      width: double.infinity,
      color: context.bgCanvas,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned.fill(child: AuroraBackground()),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              SiteHeader.height + (isMobile ? 44 : 72),
              24,
              isMobile ? 60 : 90,
            ),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  const _CountPill(),
                  const SizedBox(height: 24),
                  Text(
                    'Six apps.',
                    textAlign: TextAlign.center,
                    style: titleStyle.copyWith(color: context.textPrimary),
                  ),
                  GradientText(
                    'Every one free.',
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Native software for Windows, Mac and iPhone. '
                      'No account, no trial, no upsell.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: isMobile ? 16.5 : 19,
                        height: 1.55,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 36 : 48),
                  Reveal(child: FeaturedAppCard(product: _featured)),
                  const SizedBox(height: 20),
                  _BrowseAllLink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: context.bgGlass,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: context.borderStrong),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: const Color(0xFF2ED3B7),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2ED3B7).withValues(alpha: 0.7),
                  blurRadius: 9,
                ),
              ],
            ),
          ),
          const SizedBox(width: 9),
          Text(
            'All builds current · Windows, macOS, iOS',
            style: TextStyle(
              color: context.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowseAllLink extends StatefulWidget {
  @override
  State<_BrowseAllLink> createState() => _BrowseAllLinkState();
}

class _BrowseAllLinkState extends State<_BrowseAllLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.downloads),
        child: Text(
          'See all six apps →',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _hovered ? context.textPrimary : context.textMuted,
          ),
        ),
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgSubtle,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 68 : 104,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            const SectionEyebrow('The whole shelf'),
            const SizedBox(height: 16),
            Text(
              isMobile
                  ? 'Pick one. It installs and it just works.'
                  : 'Pick one. It installs\nand it just works.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: isMobile ? 28 : 44,
                height: 1.12,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.4,
              ),
            ),
            const SizedBox(height: 46),
            const ProductGrid(),
          ],
        ),
      ),
    );
  }
}

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: context.accentSoft,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: context.primaryAccent,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

class _WhySection extends StatelessWidget {
  const _WhySection();

  static const _points = [
    (
      Icons.bolt_rounded,
      'Native, not a wrapper',
      'Rust and Flutter underneath. No hidden browser bloating a simple tool.',
      Color(0xFFFFC94D),
    ),
    (
      Icons.lock_rounded,
      'Nothing phones home',
      'DataHop never sees your files. No desktop app here needs an account.',
      Color(0xFF2ED3B7),
    ),
    (
      Icons.card_giftcard_rounded,
      'Actually free',
      'Every desktop app installs and runs without paying us a rupee.',
      Color(0xFF6E8BFF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgCanvas,
      child: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground(intensity: 0.55)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isMobile ? 68 : 104,
            ),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  const SectionEyebrow('Why ours'),
                  const SizedBox(height: 16),
                  Text(
                    isMobile
                        ? 'Built the way we wanted to use them.'
                        : 'Built the way we\nwanted to use them.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: isMobile ? 28 : 44,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.4,
                    ),
                  ),
                  const SizedBox(height: 46),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final (i, point) in _points.indexed)
                        SizedBox(
                          width: isMobile ? double.infinity : 344,
                          child: Reveal(
                            delay: Duration(milliseconds: 70 * i),
                            child: _WhyCard(
                              icon: point.$1,
                              title: point.$2,
                              body: point.$3,
                              tint: point.$4,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  const _WhyCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.tint,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.border),
        boxShadow: context.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tint.withValues(alpha: context.isDark ? 0.18 : 0.15),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: tint, size: 23),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              color: context.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: context.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaSection extends StatelessWidget {
  const _CtaSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgSubtle,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 68 : 104,
      ),
      child: MaxWidthContainer(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 28 : 64,
            vertical: isMobile ? 48 : 76,
          ),
          decoration: BoxDecoration(
            gradient: context.accentGradient,
            borderRadius: BorderRadius.circular(28),
            boxShadow: context.shadowLifted,
          ),
          child: Column(
            children: [
              Text(
                'Start with one app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 29 : 44,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.4,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Every installer, every platform, on one page.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: isMobile ? 16 : 18,
                ),
              ),
              const SizedBox(height: 32),
              _WhiteCta(
                label: 'Open Download Center',
                onTap: () => context.go(AppRoutes.downloads),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhiteCta extends StatefulWidget {
  const _WhiteCta({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_WhiteCta> createState() => _WhiteCtaState();
}

class _WhiteCtaState extends State<_WhiteCta> {
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
          duration: const Duration(milliseconds: 160),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.3 : 0.18),
                blurRadius: _hovered ? 28 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.download_rounded,
                size: 20,
                color: Color(0xFF120E2E),
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Color(0xFF120E2E),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
