import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/breakpoints.dart';
import '../../../../core/data/products.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/widgets/components/download_button.dart';
import '../../../../core/widgets/components/product_icon.dart';

/// The hero's download offer, named.
///
/// The previous hero offered "Download for macOS" with no indication of what
/// the file actually was. This card leads with the app's icon and name, says
/// in one line what it does, and puts the product name inside the button.
class FeaturedAppCard extends StatefulWidget {
  const FeaturedAppCard({super.key, required this.product});

  final Product product;

  @override
  State<FeaturedAppCard> createState() => _FeaturedAppCardState();
}

class _FeaturedAppCardState extends State<FeaturedAppCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final isMobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          padding: EdgeInsets.all(isMobile ? 24 : 36),
          decoration: BoxDecoration(
            color: context.bgGlass,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: _hovered ? p.accent.withValues(alpha: 0.5) : context.border,
              width: 1.4,
            ),
            boxShadow: _hovered ? context.shadowScreenshot : context.shadowLifted,
          ),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: context.goldSoft,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: context.goldAccent.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        size: 14, color: context.goldAccent),
                    const SizedBox(width: 6),
                    Text(
                      'START HERE',
                      style: TextStyle(
                        color: context.goldAccent,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 22 : 28),
              ProductIcon(product: p, size: isMobile ? 82 : 100),
              SizedBox(height: isMobile ? 18 : 22),
              Text(
                p.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textPrimary,
                  fontSize: isMobile ? 32 : 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                p.tagline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textSecondary,
                  fontSize: isMobile ? 15.5 : 18,
                  height: 1.55,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 30),
              SmartDownloadCta(product: p, productNameInLabel: true),
              const SizedBox(height: 18),
              _WhatItDoesLink(product: p),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhatItDoesLink extends StatefulWidget {
  const _WhatItDoesLink({required this.product});
  final Product product;

  @override
  State<_WhatItDoesLink> createState() => _WhatItDoesLinkState();
}

class _WhatItDoesLinkState extends State<_WhatItDoesLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.product.route),
        child: Text(
          'What ${widget.product.name} does →',
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: _hovered ? context.textPrimary : context.textMuted,
          ),
        ),
      ),
    );
  }
}
