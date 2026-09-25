import 'package:flutter/material.dart';

import '../../theme/theme_manager.dart';

/// Layered colour wash behind a section.
///
/// Four large, soft blobs in the brand colours. A flat canvas read as empty;
/// this gives the page depth and colour without competing with the content,
/// and it is static — nothing here animates on a loop.
class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key, this.intensity = 1.0});

  /// Scales every blob's opacity, for sections that need a quieter wash.
  final double intensity;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDark;
    return IgnorePointer(
      child: RepaintBoundary(
        child: ClipRect(
          child: Stack(
            children: [
              _Blob(
                top: -300,
                left: -220,
                size: 860,
                color: context.primaryAccent,
                opacity: (dark ? 0.30 : 0.20) * intensity,
              ),
              _Blob(
                top: -220,
                right: -260,
                size: 780,
                color: context.violetAccent,
                opacity: (dark ? 0.28 : 0.18) * intensity,
              ),
              _Blob(
                top: 180,
                right: 60,
                size: 520,
                color: context.goldAccent,
                opacity: (dark ? 0.14 : 0.13) * intensity,
              ),
              _Blob(
                top: 320,
                left: -120,
                size: 620,
                color: const Color(0xFF2ED3B7),
                opacity: (dark ? 0.13 : 0.11) * intensity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.size,
    required this.color,
    required this.opacity,
    this.top,
    this.left,
    this.right,
  });

  final double size;
  final Color color;
  final double opacity;
  final double? top;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              Colors.transparent,
            ],
            stops: const [0.0, 0.72],
          ),
        ),
      ),
    );
  }
}

/// Paints text with a gradient. Used on the one word per headline that should
/// carry the brand colours.
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final Gradient? gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final g = gradient ?? context.brandGradient;
    return ShaderMask(
      shaderCallback: (bounds) =>
          g.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
