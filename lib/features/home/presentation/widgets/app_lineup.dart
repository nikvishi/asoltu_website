import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/products.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/widgets/components/product_icon.dart';

/// The whole catalogue as a glass dock of real app icons.
///
/// Stands in for a hero screenshot: the desktop apps have no usable captures
/// yet, and a real icon shelf reads as a genuine product family where an empty
/// window mockup reads as a placeholder.
class AppLineup extends StatelessWidget {
  const AppLineup({super.key, this.iconSize = 84});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: iconSize * 0.34,
        vertical: iconSize * 0.30,
      ),
      decoration: BoxDecoration(
        color: context.bgGlass,
        borderRadius: BorderRadius.circular(iconSize * 0.42),
        border: Border.all(color: context.border),
        boxShadow: context.shadowScreenshot,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: iconSize * 0.30,
        runSpacing: iconSize * 0.30,
        children: [
          for (final p in kProducts)
            _LineupIcon(product: p, size: iconSize),
        ],
      ),
    );
  }
}

class _LineupIcon extends StatefulWidget {
  const _LineupIcon({required this.product, required this.size});

  final Product product;
  final double size;

  @override
  State<_LineupIcon> createState() => _LineupIconState();
}

class _LineupIconState extends State<_LineupIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.product.route),
        child: Tooltip(
          message: widget.product.name,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            // Dock-style lift on hover.
            transform: Matrix4.translationValues(
              0,
              _hovered ? -widget.size * 0.10 : 0,
              0,
            ),
            child: ProductIcon(product: widget.product, size: widget.size),
          ),
        ),
      ),
    );
  }
}
