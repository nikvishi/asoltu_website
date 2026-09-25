import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/products.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/utils/host_platform.dart';
import '../../../../core/widgets/components/download_button.dart';
import '../../../../core/widgets/components/product_icon.dart';
import 'reveal.dart';

/// Every product as a card carrying its real icon, a screenshot and its own
/// download button — so a visitor can install something without leaving the
/// homepage.
class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, this.products});

  /// Defaults to the whole catalogue; hubs pass a filtered slice.
  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    final items = products ?? kProducts;

    // Sized off the real available width rather than the window width, so the
    // container's own padding cannot push a column onto the next row.
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 20.0;
        final available = constraints.maxWidth;
        final columns = available >= 1000
            ? 3
            : available >= 620
            ? 2
            : 1;
        final cardWidth = columns == 1
            ? available
            : (available - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          alignment: WrapAlignment.center,
          children: [
            for (final (i, p) in items.indexed)
              SizedBox(
                width: cardWidth,
                child: RepaintBoundary(
                  child: Reveal(
                    delay: Duration(milliseconds: 60 * i),
                    child: ProductCard(product: p),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final shot = p.heroShot;
    // Offer the build matching the visitor's OS, not whichever is listed first.
    final host = detectHostPlatform();
    final primaryBuild =
        (host == null ? null : p.buildFor(host)) ?? p.builds.first;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(p.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? p.accent.withValues(alpha: 0.45)
                  : context.border,
            ),
            boxShadow: _hovered ? context.shadowLifted : context.shadowCard,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _CardArt(product: p, shot: shot, hovered: _hovered),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ProductIcon(product: p, size: 44),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  style: TextStyle(
                                    color: context.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  p.builds
                                      .map((b) => b.platform.label)
                                      .join(' · '),
                                  style: TextStyle(
                                    color: context.textMuted,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        p.tagline,
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 14.5,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Stops the card's own tap from firing when the visitor
                      // aims at the download button.
                      GestureDetector(
                        onTap: () {},
                        child: DownloadButton(
                          product: p,
                          build: primaryBuild,
                          compact: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Colour panel at the top of a card.
///
/// Each product owns a hue, used at full strength here rather than as a faint
/// wash — the muted version made every card look the same.
class _CardArt extends StatelessWidget {
  const _CardArt({
    required this.product,
    required this.shot,
    required this.hovered,
  });

  final Product product;
  final String? shot;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDark;
    return SizedBox(
      height: 176,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  product.accent.withValues(alpha: dark ? 0.55 : 0.42),
                  product.accent.withValues(alpha: dark ? 0.18 : 0.14),
                ],
              ),
            ),
          ),
          // Soft highlight so the panel reads as lit rather than flat.
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: dark ? 0.16 : 0.42),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          if (shot == null)
            Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOut,
                scale: hovered ? 1.07 : 1,
                child: ProductIcon(product: product, size: 88),
              ),
            )
          else
            Positioned(
              left: 28,
              right: -36,
              top: 30,
              bottom: -28,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                scale: hovered ? 1.04 : 1,
                alignment: Alignment.topLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    boxShadow: context.shadowLifted,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    child: Image.asset(
                      shot!,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (context, error, stack) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
