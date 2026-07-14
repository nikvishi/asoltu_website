import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Lightweight entrance animation for section content.
/// Respects platform reduce-motion / disable-animations preferences.
class FadeIn extends StatelessWidget {
  const FadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 380),
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) return child;

    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOut)
        .slideY(
          begin: 0.03,
          end: 0,
          duration: duration,
          curve: Curves.easeOutCubic,
        );
  }
}
