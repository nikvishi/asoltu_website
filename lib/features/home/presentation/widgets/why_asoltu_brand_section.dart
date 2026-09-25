import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Premium branding section — why organizations choose ASOLTU.
class WhyAsoltuBrandSection extends StatelessWidget {
  const WhyAsoltuBrandSection({super.key});

  static const _highlights = <String>[
    'Modern Software Engineering',
    'AI Powered Products',
    'Flutter Expertise',
    'Enterprise Architecture',
    'Scalable Cloud Systems',
    'Cross Platform Development',
    'Custom Software Solutions',
    'Future Ready Technology',
    'Dedicated Support',
    'Continuous Improvements',
    'Innovation Driven Culture',
  ];

  static const _badges = <String>[
    'Flutter',
    'Firebase',
    'Cloud',
    'AI',
    'REST APIs',
    'Multi-tenant',
    'RBAC',
    'Mobile + Web',
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Why ASOLTU',
              title: 'A technology partner built for the long term',
              subtitle:
                  'ASOLTU Technologies is a modern software engineering company. We build intelligent products for schools and businesses — starting with School ERP and extending into custom, AI-ready cloud software.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: AppColors.navyHero,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Column(
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final h in _highlights)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.14),
                          ),
                        ),
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Technology badges',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final b in _badges)
                      Chip(
                        label: Text(b),
                        backgroundColor: Colors.white,
                        labelStyle: const TextStyle(
                          color: AppColors.brandNavy,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        side: BorderSide.none,
                      ),
                  ],
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AsoltuButton(
                      label: 'About ASOLTU',
                      onPressed: () => context.go(AppRoutes.about),
                    ),
                    AsoltuButton(
                      label: 'Book Demo',
                      variant: AsoltuButtonVariant.gold,
                      onPressed: () => showBookDemoDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
