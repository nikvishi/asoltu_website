import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import 'max_width_container.dart';

/// Standard vertical marketing section wrapper with responsive padding.
class PageSection extends StatelessWidget {
  const PageSection({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.maxWidth,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final vPad = width >= 1400
        ? AppSpacing.section + 8
        : width < 600
            ? AppSpacing.section - 12
            : AppSpacing.section;

    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: vPad),
        child: MaxWidthContainer(
          maxWidth: maxWidth ?? 1200,
          child: child,
        ),
      ),
    );
  }
}
