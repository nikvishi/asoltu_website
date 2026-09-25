import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

/// Product page rendered straight from [Product].
///
/// Everything a product page shows — screenshots, builds, features, version —
/// comes from `core/data/products.dart`, so a new release is one edit in one
/// file rather than three pages drifting apart.
class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RepaintBoundary(child: _Hero(product: product)),
        RepaintBoundary(child: _Features(product: product)),
        if (product.screenshots.length > 1)
          RepaintBoundary(child: _Gallery(product: product)),
        if (product.supportEmail != null)
          RepaintBoundary(child: _SupportContact(product: product)),
        RepaintBoundary(child: _BottomCta(product: product)),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < Breakpoints.mobile;
    final shot = product.heroShot;
    final isPhoneApp = !product.isDesktop;

    return Container(
      color: context.bgCanvas,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned.fill(child: AuroraBackground()),
          Positioned(
            top: -240,
            child: IgnorePointer(
              child: Container(
                width: 960,
                height: 660,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      product.accent.withValues(
                        alpha: context.isDark ? 0.40 : 0.26,
                      ),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              SiteHeader.height + (isMobile ? 48 : 84),
              24,
              isMobile ? 56 : 88,
            ),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  ProductIcon(product: product, size: isMobile ? 76 : 92),
                  const SizedBox(height: 26),
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: isMobile ? 38 : 60,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(
                      product.tagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.textPrimary,
                        fontSize: isMobile ? 19 : 24,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: 17,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  SmartDownloadCta(product: product, productNameInLabel: true),
                  SizedBox(height: isMobile ? 48 : 72),
                  if (shot != null)
                    Reveal(
                      child: isPhoneApp
                          ? PhoneFrame(
                              width: isMobile ? 230 : 270,
                              child: Image.asset(
                                shot,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.medium,
                                errorBuilder: (context, error, stack) =>
                                    const SizedBox.shrink(),
                              ),
                            )
                          : AppWindowFrame(
                              title: product.name,
                              maxWidth: 940,
                              radius: isMobile ? 10 : 16,
                              child: Image.asset(
                                shot,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.medium,
                                errorBuilder: (context, error, stack) =>
                                    const SizedBox.shrink(),
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

class _Features extends StatelessWidget {
  const _Features({required this.product});
  final Product product;

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
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            for (final (i, f) in product.features.indexed)
              SizedBox(
                width: isMobile ? double.infinity : 344,
                child: Reveal(
                  delay: Duration(milliseconds: 70 * i),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: context.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.border),
                      boxShadow: context.shadowCard,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: product.accent.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(f.icon, color: product.accent, size: 22),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          f.title,
                          style: TextStyle(
                            color: context.textPrimary,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          f.description,
                          style: TextStyle(
                            color: context.textSecondary,
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Remaining screenshots, framed the same way as the hero shot.
class _Gallery extends StatelessWidget {
  const _Gallery({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;
    final rest = product.screenshots.skip(1).toList();
    final isPhoneApp = !product.isDesktop;

    return Container(
      color: context.bgCanvas,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 68 : 104,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'A closer look',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: isMobile ? 28 : 42,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.3,
              ),
            ),
            const SizedBox(height: 44),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                for (final (i, s) in rest.indexed)
                  Reveal(
                    delay: Duration(milliseconds: 70 * i),
                    child: isPhoneApp
                        ? PhoneFrame(
                            width: isMobile ? 200 : 230,
                            child: Image.asset(
                              s,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                              errorBuilder: (context, error, stack) =>
                                  const SizedBox.shrink(),
                            ),
                          )
                        : SizedBox(
                            width: isMobile ? double.infinity : 520,
                            child: AppWindowFrame(
                              title: product.name,
                              radius: 12,
                              shadow: context.shadowCard,
                              child: Image.asset(
                                s,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.medium,
                                errorBuilder: (context, error, stack) =>
                                    const SizedBox.shrink(),
                              ),
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

/// Questions or support requests about this app, for stores that link their
/// listing's Support URL straight at this page.
class _SupportContact extends StatelessWidget {
  const _SupportContact({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;
    final email = product.supportEmail!;

    return Container(
      color: context.bgCanvas,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 40 : 56,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Questions or need help?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'For support requests about ${product.name}, email us and we\'ll get back to you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textSecondary,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 18),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse('mailto:$email')),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.bgSubtle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: context.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 18,
                        color: product.accent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        email,
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The download offer repeated at the end, so a visitor who read the whole
/// page does not have to scroll back up to act on it.
class _BottomCta extends StatelessWidget {
  const _BottomCta({required this.product});
  final Product product;

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
            ProductIcon(product: product, size: 64),
            const SizedBox(height: 24),
            Text(
              'Get ${product.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: isMobile ? 30 : 44,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Version ${product.version}',
              style: TextStyle(color: context.textMuted, fontSize: 15),
            ),
            const SizedBox(height: 30),
            SmartDownloadCta(product: product, productNameInLabel: true),
          ],
        ),
      ),
    );
  }
}
