import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Introduces School ERP as Asoltu Tech’s flagship product.
/// Does not replace existing ERP sections — only frames them.
class FlagshipProductIntro extends StatelessWidget {
  const FlagshipProductIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      padding: const EdgeInsets.only(
        top: AppSpacing.section,
        bottom: AppSpacing.xl,
      ),
      child: FadeIn(
        child: Column(
          children: [
            Text(
              'OUR FLAGSHIP PRODUCT',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.accentGoldDark,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'ASOLTU SCHOOL ERP',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'One Platform.\nComplete School Management.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                'School ERP and student management system for modern institutions — '
                'admissions, attendance, fees, exams, HR, parent apps and school automation '
                'in one secure education ERP cloud platform from Asoltu Tech, serving schools '
                'across India including Rajasthan.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
