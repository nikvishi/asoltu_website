import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/data/products.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/widgets/layout/max_width_container.dart';
import '../../../core/widgets/layout/site_header.dart';
import '../../home/presentation/home_page.dart' show SectionEyebrow;
import '../../home/presentation/widgets/product_grid.dart';
import '../../home/presentation/widgets/reveal.dart';

/// A non-downloadable destination shown alongside the product cards — the ERP
/// and Exam Series, which are demo-led rather than install-led.
class HubLink {
  const HubLink(this.title, this.description, this.route, this.icon);
  final String title;
  final String description;
  final String route;
  final IconData icon;
}

/// Shared layout for the /products, /software, /education and /business hubs:
/// a heading, then the same product cards the homepage uses, so every route
/// into the catalogue offers a download rather than another menu.
class ProductHubPage extends StatelessWidget {
  const ProductHubPage({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.products,
    this.links = const [],
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final List<Product> products;
  final List<HubLink> links;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: context.bgCanvas,
          padding: EdgeInsets.fromLTRB(
            24,
            SiteHeader.height + (isMobile ? 48 : 84),
            24,
            isMobile ? 48 : 68,
          ),
          child: MaxWidthContainer(
            child: Column(
              children: [
                SectionEyebrow(eyebrow),
                const SizedBox(height: 14),
                Text(
                  // Forced breaks are for wide screens only; on a phone they
                  // push the line past the viewport instead of wrapping.
                  isMobile ? title.replaceAll('\n', ' ') : title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.textPrimary,
                    fontSize: isMobile ? 30 : 54,
                    height: 1.08,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 18),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: isMobile ? 16 : 19,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (products.isNotEmpty)
          Container(
            color: context.bgCanvas,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isMobile ? 16 : 24,
            ),
            child: MaxWidthContainer(
              child: ProductGrid(products: products),
            ),
          ),
        if (links.isNotEmpty)
          Container(
            color: context.bgSubtle,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isMobile ? 68 : 100,
            ),
            child: MaxWidthContainer(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  for (final (i, l) in links.indexed)
                    SizedBox(
                      width: isMobile ? double.infinity : 424,
                      child: Reveal(
                        delay: Duration(milliseconds: 70 * i),
                        child: _HubLinkCard(link: l),
                      ),
                    ),
                ],
              ),
            ),
          ),
        SizedBox(height: isMobile ? 40 : 64),
      ],
    );
  }
}

class _HubLinkCard extends StatefulWidget {
  const _HubLinkCard({required this.link});
  final HubLink link;

  @override
  State<_HubLinkCard> createState() => _HubLinkCardState();
}

class _HubLinkCardState extends State<_HubLinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final l = widget.link;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(l.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? context.primaryAccent : context.border,
            ),
            boxShadow: _hovered ? context.shadowLifted : context.shadowCard,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.accentSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(l.icon, color: context.primaryAccent, size: 24),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.title,
                      style: TextStyle(
                        color: context.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l.description,
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: 14.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: _hovered ? context.primaryAccent : context.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
