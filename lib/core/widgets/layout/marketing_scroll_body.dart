import 'package:flutter/material.dart';

import 'site_footer.dart';

/// Scrollable marketing page body with shared footer.
///
/// Must be used as the shell child (or page root) so long pages scroll
/// instead of overflowing a viewport-bounded [Column].
class MarketingScrollBody extends StatelessWidget {
  const MarketingScrollBody({
    super.key,
    required this.child,
    this.showFooter = true,
  });

  final Widget child;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    final primary = PrimaryScrollController.maybeOf(context);
    return SingleChildScrollView(
      controller: primary,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (showFooter) const SiteFooter(),
        ],
      ),
    );
  }
}
