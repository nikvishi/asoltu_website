import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Product roadmap — replaces fake testimonials with honest product direction.
class RoadmapSection extends StatelessWidget {
  const RoadmapSection({super.key});

  static const _columns = <(String, String, Color, List<String>)>[
    (
      'Current features',
      'What we are shipping today',
      AppColors.accentBlue,
      [
        'School ERP core modules',
        'Role-based admin, teacher, parent, student access',
        'Fees, attendance, exams and communication',
        'Flutter web and mobile experiences',
        'Cloud-hosted multi-tenant foundations',
        'Demo and lead workflows for institutions',
      ],
    ),
    (
      'Upcoming features',
      'Active product development focus',
      AppColors.accentGoldDark,
      [
        'Deeper AI report narratives',
        'Richer analytics for campus leadership',
        'Expanded offline-ready operational flows',
        'Improved onboarding playbooks',
        'Broader integrations and automation hooks',
        'UI polish across all role portals',
      ],
    ),
    (
      'Future vision',
      'Where we are building toward',
      AppColors.brandNavy,
      [
        'Intelligent operations for every campus role',
        'Stronger DPDP-aligned data practices',
        'Broader business software products',
        'Industry-ready AI assistants for education',
        'Seamless multi-campus intelligence',
        'A durable Indian software brand',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Product roadmap',
              title: 'What we are building',
              subtitle:
                  'No fake reviews. A transparent view of current capabilities, near-term work and long-term product vision.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 960;
              final cards = [
                for (final col in _columns) _RoadmapCard(data: col),
              ];
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      if (i > 0) const SizedBox(width: 16),
                      Expanded(child: cards[i]),
                    ],
                  ],
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(height: 16),
                    cards[i],
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard({required this.data});
  final (String, String, Color, List<String>) data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: data.$3.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              data.$1.toUpperCase(),
              style: TextStyle(
                color: data.$3,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.$2,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          for (final item in data.$4)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: data.$3,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.4,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
