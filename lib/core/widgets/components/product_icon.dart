import 'package:flutter/material.dart';

import '../../data/products.dart';
import '../../theme/theme_manager.dart';

/// The real app icon, in the squircle-ish shape macOS and iOS use, with a
/// coloured halo picked up from the product's accent.
///
/// Replaces the stock Material icons that used to stand in for each product —
/// the actual icon is what makes a product card read as real software.
class ProductIcon extends StatelessWidget {
  const ProductIcon({
    super.key,
    required this.product,
    this.size = 64,
    this.glow = true,
  });

  final Product product;
  final double size;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.235),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: product.accent
                      .withValues(alpha: context.isDark ? 0.42 : 0.30),
                  blurRadius: size * 0.55,
                  spreadRadius: -size * 0.12,
                  offset: Offset(0, size * 0.12),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.235),
        child: Image.asset(
          product.iconAsset,
          width: size,
          height: size,
          fit: BoxFit.cover,
          // Source art is 512px but is drawn at 34-100px; decoding at the
          // painted size keeps six of these off the GPU budget.
          cacheWidth: (size * 3).round(),
          cacheHeight: (size * 3).round(),
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, error, stack) => Container(
            color: product.accent.withValues(alpha: 0.16),
            alignment: Alignment.center,
            child: Text(
              product.name.characters.first,
              style: TextStyle(
                fontSize: size * 0.44,
                fontWeight: FontWeight.w800,
                color: product.accent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
