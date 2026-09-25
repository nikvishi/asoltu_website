import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';
import '../data/landing_content.dart';

/// Shared premium template for SEO module/service landing pages.
class SeoLandingPage extends StatelessWidget {
  const SeoLandingPage({super.key, required this.data});

  final LandingPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 16),
          child: FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: data.title),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    data.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.accentBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SectionHeading(
                  title: data.headline,
                  subtitle: data.subheadline,
                  center: true,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AsoltuButton(
                      label: 'Book Demo',
                      icon: Icons.calendar_month_outlined,
                      onPressed: () => showBookDemoDialog(context),
                    ),
                    AsoltuButton(
                      label: 'Contact Us',
                      variant: AsoltuButtonVariant.secondary,
                      onPressed: () => context.go(AppRoutes.contact),
                    ),
                    AsoltuButton(
                      label: 'Call ${AppUrls.phoneDisplay}',
                      variant: AsoltuButtonVariant.ghost,
                      icon: Icons.call_outlined,
                      onPressed: () => launchUrl(
                        Uri.parse(AppUrls.phoneTel),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Capabilities',
                title: 'What you get',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900
                      ? 2
                      : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.bullets.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: cols == 1 ? 4.5 : 3.2,
                    ),
                    itemBuilder: (context, i) {
                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: AppShadows.soft,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.accentBlue,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                data.bullets[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brandNavy,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'FAQ',
                title: 'Common questions',
                center: true,
              ),
              const SizedBox(height: 20),
              for (final f in data.faqs)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f.$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandNavy,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        f.$2,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: AppColors.navyHero,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              children: [
                Text(
                  'Ready to discuss ${data.title}?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppUrls.infoEmailDisplay} · ${AppUrls.phoneDisplay}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AsoltuButton(
                      label: 'Book Demo',
                      onPressed: () => showBookDemoDialog(context),
                    ),
                    AsoltuButton(
                      label: 'View all solutions',
                      variant: AsoltuButtonVariant.gold,
                      onPressed: () => context.go(AppRoutes.products),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
