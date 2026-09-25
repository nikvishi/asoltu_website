import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/data/products.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/widgets/components/app_window_frame.dart';
import '../../../core/widgets/components/aurora_background.dart';
import '../../../core/widgets/components/download_button.dart';
import '../../../core/widgets/components/product_icon.dart';
import '../../../core/widgets/layout/max_width_container.dart';
import '../../../core/widgets/layout/site_header.dart';
import '../../home/presentation/widgets/reveal.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_Hero(), _ReleaseList(), _InstallHelp()],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgCanvas,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned.fill(child: AuroraBackground()),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              SiteHeader.height + (isMobile ? 48 : 84),
              24,
              isMobile ? 40 : 64,
            ),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  GradientText(
                    'Download Center',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 36 : 58,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Every ASOLTU app, latest build, for Windows, macOS and iOS. '
                      'Free, and nothing asks you to sign up first.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: isMobile ? 16 : 18,
                        height: 1.6,
                      ),
                    ),
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

class _ReleaseList extends StatelessWidget {
  const _ReleaseList();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgCanvas,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 24 : 40,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            for (final (i, p) in kProducts.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: RepaintBoundary(
                  child: Reveal(
                    delay: Duration(milliseconds: 50 * i),
                    child: _ReleaseCard(product: p),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// One product: icon, what it does, every build it ships, and a screenshot so
/// the visitor can see it before committing to an installer.
class _ReleaseCard extends StatelessWidget {
  const _ReleaseCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < Breakpoints.tablet;
    final shot = product.heroShot;

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductIcon(product: product, size: 56),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wrap, not Row: on a phone the chip squeezed the name into
                  // a mid-word break.
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.7,
                        ),
                      ),
                      _VersionChip(version: product.version),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.tagline,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final b in product.builds)
              DownloadButton(product: product, build: b, compact: true),
          ],
        ),
        const SizedBox(height: 16),
        for (final b in product.builds)
          if (b.requirements != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Icon(b.platform.icon, size: 13, color: context.textMuted),
                  const SizedBox(width: 7),
                  Flexible(
                    child: Text(
                      b.size == null
                          ? b.requirements!
                          : '${b.requirements!} · ${b.size}',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: context.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        const SizedBox(height: 12),
        _LearnMoreLink(route: product.route),
      ],
    );

    // Portrait phone captures need phone chrome; a macOS window around a
    // 9:19.5 image just letterboxes it.
    final art = shot == null
        ? null
        : product.isDesktop
        ? AppWindowFrame(
            title: product.name,
            radius: 10,
            shadow: context.shadowCard,
            child: Image.asset(
              shot,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, error, stack) => const SizedBox.shrink(),
            ),
          )
        : Center(
            child: PhoneFrame(
              width: 200,
              child: Image.asset(
                shot,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.medium,
                errorBuilder: (context, error, stack) =>
                    const SizedBox.shrink(),
              ),
            ),
          );

    return Container(
      padding: EdgeInsets.all(isNarrow ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              product.accent.withValues(alpha: context.isDark ? 0.14 : 0.10),
              context.bgCard,
            ),
            context.bgCard,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: product.accent.withValues(alpha: context.isDark ? 0.30 : 0.24),
        ),
        boxShadow: context.shadowCard,
      ),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                details,
                if (art != null) ...[const SizedBox(height: 28), art],
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: details),
                if (art != null) ...[
                  const SizedBox(width: 36),
                  Expanded(flex: 4, child: art),
                ],
              ],
            ),
    );
  }
}

class _VersionChip extends StatelessWidget {
  const _VersionChip({required this.version});
  final String version;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: context.accentSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'v$version',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: context.primaryAccent,
        ),
      ),
    );
  }
}

class _LearnMoreLink extends StatefulWidget {
  const _LearnMoreLink({required this.route});
  final String route;

  @override
  State<_LearnMoreLink> createState() => _LearnMoreLinkState();
}

class _LearnMoreLinkState extends State<_LearnMoreLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Text(
          'See what it does →',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _hovered ? context.textPrimary : context.primaryAccent,
          ),
        ),
      ),
    );
  }
}

/// Unsigned installers trip SmartScreen and Gatekeeper. Saying so up front
/// costs one section and saves a support ticket per download.
class _InstallHelp extends StatelessWidget {
  const _InstallHelp();

  static const _steps = [
    (
      Icons.window_rounded,
      'Windows says "Windows protected your PC"',
      'Click More info, then Run anyway. This appears because our installers are '
          'not code-signed yet, not because anything is wrong with the file.',
    ),
    (
      Icons.apple,
      'macOS says the app is from an unidentified developer',
      'Open System Settings → Privacy & Security, find the blocked app near the '
          'bottom and choose Open Anyway. You only have to do this once.',
    ),
    (
      Icons.help_outline_rounded,
      'Still stuck?',
      'Write to info@asoltu.com with the app name and your OS version and we '
          'will walk you through it.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Container(
      color: context.bgSubtle,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 64 : 96,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Trouble installing?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.2,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                for (final (icon, title, body) in _steps)
                  SizedBox(
                    width: isMobile ? double.infinity : 344,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: context.bgCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, color: context.primaryAccent, size: 22),
                          const SizedBox(height: 16),
                          Text(
                            title,
                            style: TextStyle(
                              color: context.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            body,
                            style: TextStyle(
                              color: context.textSecondary,
                              fontSize: 14.5,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
