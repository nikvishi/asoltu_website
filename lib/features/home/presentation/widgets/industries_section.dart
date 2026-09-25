import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class IndustriesSection extends StatelessWidget {
  const IndustriesSection({super.key});

  static const _industries = <(IconData, String, String)>[
    (Icons.school_outlined, 'Schools', 'K–12 campuses needing daily operational reliability.'),
    (Icons.account_balance_outlined, 'Colleges', 'Department-aware administration and assessments.'),
    (Icons.apartment_outlined, 'Universities', 'Complex multi-role academic operations.'),
    (Icons.menu_book_outlined, 'Coaching Institutes', 'High-volume batches, enquiries and fee cycles.'),
    (Icons.cast_for_education_outlined, 'Training Centers', 'Programs, schedules and learner management.'),
    (Icons.business_outlined, 'Businesses', 'Custom software, apps and cloud systems.'),
    (Icons.hub_outlined, 'Educational Organizations', 'Groups and networks with multi-campus needs.'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Industries we serve',
              title: 'Education institutions and growing businesses',
              subtitle:
                  'Purpose-built for education operations — and engineered to deliver custom software for business teams.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1100
                  ? 4
                  : c.maxWidth >= 720
                      ? 3
                      : c.maxWidth >= 500
                          ? 2
                          : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _industries.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 1 ? 3.0 : 1.3,
                ),
                itemBuilder: (context, i) {
                  final ind = _industries[i];
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(ind.$1, color: AppColors.accentBlue, size: 28),
                        const SizedBox(height: 12),
                        Text(
                          ind.$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.brandNavy,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            ind.$3,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              height: 1.45,
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
    );
  }
}
