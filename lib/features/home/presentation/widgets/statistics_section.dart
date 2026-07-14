import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import 'animated_counter.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Impact',
              title: 'Numbers that matter',
              subtitle:
                  'Representative scale indicators for institutions evaluating ASOLTU across campuses, staff, and finance workflows.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 900
                  ? 4
                  : c.maxWidth >= 600
                      ? 2
                      : 1;
              return GridView.count(
                crossAxisCount: cols,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: cols == 1 ? 2.6 : 1.45,
                children: const [
                  _StatCard(
                    child: AnimatedCounter(
                      value: 480,
                      suffix: '+',
                      label: 'Schools',
                    ),
                  ),
                  _StatCard(
                    child: AnimatedCounter(
                      value: 250000,
                      suffix: '+',
                      label: 'Students',
                    ),
                  ),
                  _StatCard(
                    child: AnimatedCounter(
                      value: 18000,
                      suffix: '+',
                      label: 'Teachers',
                    ),
                  ),
                  _StatCard(
                    child: AnimatedCounter(
                      value: 12,
                      suffix: 'M+',
                      label: 'Transactions',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Center(child: child),
    );
  }
}
