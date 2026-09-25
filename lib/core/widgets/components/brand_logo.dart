import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../routing/route_names.dart';
import '../../theme/theme_manager.dart';

/// ASOLTU mark and wordmark, used in the header and footer.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.onNavy = false,
    this.showWordmark = true,
    this.height = 36,
  });

  final bool onNavy;
  final bool showWordmark;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${AppStrings.brandName} home',
      button: true,
      child: InkWell(
        onTap: () => context.go(AppRoutes.home),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(height * 0.26),
              child: Image.asset(
                // The webp decoded inconsistently on web and left an empty
                // box in the header; the PNG is reliable.
                AppAssets.logoPng,
                width: height,
                height: height,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                gaplessPlayback: true,
                semanticLabel: 'ASOLTU logo',
                errorBuilder: (context, error, stack) => Container(
                  width: height,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: context.accentGradient,
                    borderRadius: BorderRadius.circular(height * 0.26),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.55,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            if (showWordmark) ...[
              const SizedBox(width: 10),
              Text(
                AppStrings.brandName,
                style: TextStyle(
                  fontSize: height * 0.46,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  color: onNavy ? Colors.white : context.textPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
