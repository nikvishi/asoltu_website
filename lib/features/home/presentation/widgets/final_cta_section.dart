import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class FinalCtaSection extends StatelessWidget {
  const FinalCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 52),
        decoration: BoxDecoration(
          gradient: AppColors.navyHero,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          children: [
            Text(
              'Ready to modernize your school?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                'Book a live demo with our team, or contact sales for multi-campus enterprise plans.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.86),
                    ),
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                AsoltuButton(
                  label: 'Book Demo',
                  icon: Icons.calendar_month_outlined,
                  onPressed: () => context.go(AppRoutes.contact),
                ),
                AsoltuButton(
                  label: 'Contact Sales',
                  variant: AsoltuButtonVariant.gold,
                  icon: Icons.support_agent_outlined,
                  onPressed: () => launchUrl(
                    Uri.parse(AppUrls.salesEmail),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
