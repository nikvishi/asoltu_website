import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../routing/route_names.dart';
import '../../theme/app_colors.dart';

/// ASOLTU wordmark / mark used in header and footer.
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
    final textColor = onNavy ? Colors.white : AppColors.brandNavy;

    return Semantics(
      label: '${AppStrings.brandName} home',
      button: true,
      child: InkWell(
        onTap: () => context.go(AppRoutes.home),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.accentGold.withValues(alpha: 0.5),
                ),
                color: onNavy
                    ? Colors.white.withValues(alpha: 0.1)
                    : AppColors.surfaceMuted,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                AppAssets.logo,
                fit: BoxFit.cover,
                cacheWidth: 96,
                cacheHeight: 96,
                filterQuality: FilterQuality.medium,
                semanticLabel: '${AppStrings.brandName} logo',
                errorBuilder: (_, _, _) => Icon(
                  Icons.school_rounded,
                  size: height * 0.55,
                  color: onNavy ? AppColors.accentGold : AppColors.brandNavy,
                ),
              ),
            ),
            if (showWordmark) ...[
              const SizedBox(width: 10),
              Text(
                AppStrings.brandName,
                style: TextStyle(
                  fontSize: height * 0.48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  color: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
