import 'package:flutter/material.dart';

import '../../theme/theme_manager.dart';

/// Wraps a screenshot in macOS-style window chrome.
///
/// A bare screenshot reads as a picture; the same screenshot inside a titled
/// window with traffic lights reads as software. Every product shot on the
/// site goes through here.
class AppWindowFrame extends StatelessWidget {
  const AppWindowFrame({
    super.key,
    required this.child,
    this.title,
    this.radius = 14,
    this.shadow,
    this.maxWidth,
  });

  final Widget child;

  /// Shown centred in the title bar. Usually the product name.
  final String? title;
  final double radius;

  /// Defaults to the deep screenshot shadow.
  final List<BoxShadow>? shadow;
  final double? maxWidth;

  static const _trafficLights = [
    Color(0xFFFF5F57),
    Color(0xFFFEBC2E),
    Color(0xFF28C840),
  ];

  @override
  Widget build(BuildContext context) {
    final barColor =
        context.isDark ? const Color(0xFF23262E) : const Color(0xFFE9EBEF);

    final frame = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: context.border),
        boxShadow: shadow ?? context.shadowScreenshot,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 32,
              color: barColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  for (final c in _trafficLights) ...[
                    Container(
                      width: 11,
                      height: 11,
                      decoration:
                          BoxDecoration(color: c, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 7),
                  ],
                  Expanded(
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: context.textMuted,
                      ),
                    ),
                  ),
                  // Balances the traffic lights so the title sits centred.
                  const SizedBox(width: 54),
                ],
              ),
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );

    if (maxWidth == null) return frame;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: frame,
      ),
    );
  }
}

/// Phone-shaped chrome for the iOS-only products, so their portrait
/// screenshots do not get stretched into a desktop frame.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child, this.width = 240});

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    final radius = width * 0.14;
    return Container(
      width: width,
      padding: EdgeInsets.all(width * 0.032),
      decoration: BoxDecoration(
        color: context.isDark ? const Color(0xFF1B1E25) : const Color(0xFF2A2D35),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: context.shadowScreenshot,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - width * 0.032),
        child: AspectRatio(aspectRatio: 9 / 19.5, child: child),
      ),
    );
  }
}
