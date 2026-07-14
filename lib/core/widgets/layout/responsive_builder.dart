import 'package:flutter/material.dart';

import '../../constants/breakpoints.dart';

enum SiteBreakpoint { mobile, tablet, desktop, wide }

/// Resolves marketing layout breakpoints.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, SiteBreakpoint bp, BoxConstraints c)
      builder;

  static SiteBreakpoint of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= Breakpoints.wide) return SiteBreakpoint.wide;
    if (w >= Breakpoints.desktop) return SiteBreakpoint.desktop;
    if (w >= Breakpoints.tablet) return SiteBreakpoint.tablet;
    return SiteBreakpoint.mobile;
  }

  static bool isMobile(BuildContext context) =>
      of(context) == SiteBreakpoint.mobile;

  static bool isDesktop(BuildContext context) {
    final bp = of(context);
    return bp == SiteBreakpoint.desktop || bp == SiteBreakpoint.wide;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final bp = w >= Breakpoints.wide
            ? SiteBreakpoint.wide
            : w >= Breakpoints.desktop
                ? SiteBreakpoint.desktop
                : w >= Breakpoints.tablet
                    ? SiteBreakpoint.tablet
                    : SiteBreakpoint.mobile;
        return builder(context, bp, constraints);
      },
    );
  }
}
