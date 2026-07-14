import 'package:flutter/material.dart';

import '../../constants/breakpoints.dart';
import '../../theme/app_spacing.dart';

/// Centers content with max width and responsive horizontal padding.
class MaxWidthContainer extends StatelessWidget {
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.contentMax,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final double hPad;
    if (width >= 1600) {
      hPad = AppSpacing.pageXDesktop + 16;
    } else if (width >= Breakpoints.desktop) {
      hPad = AppSpacing.pageXDesktop;
    } else if (width < 380) {
      hPad = 16;
    } else {
      hPad = AppSpacing.pageX;
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: hPad),
          child: child,
        ),
      ),
    );
  }
}
