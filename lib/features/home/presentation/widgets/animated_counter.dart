import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Lightweight animated integer counter for trust metrics.
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.label,
    this.suffix = '',
    this.prefix = '',
    this.duration = const Duration(milliseconds: 1400),
  });

  final int value;
  final String label;
  final String suffix;
  final String prefix;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return Column(
          children: [
            Text(
              '$prefix${v.round()}$suffix',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        );
      },
    );
  }
}
