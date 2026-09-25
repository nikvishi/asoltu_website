import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class OurProcessSection extends StatelessWidget {
  const OurProcessSection({super.key});

  static const _steps = <(String, String, String)>[
    (
      '01',
      'Discover',
      'Understand goals, workflows, constraints and success criteria.',
    ),
    (
      '02',
      'Design',
      'Map product experience, architecture and implementation plan.',
    ),
    (
      '03',
      'Develop',
      'Build with Flutter, cloud services and clean engineering practices.',
    ),
    (
      '04',
      'Deploy',
      'Launch securely with configuration, training and go-live support.',
    ),
    (
      '05',
      'Support',
      'Continuous improvements, updates and dedicated technical assistance.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Development process',
              title: 'From discovery to ongoing support',
              subtitle:
                  'A clear path for School ERP rollouts and custom software engagements.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final horizontal = c.maxWidth >= 900;
              if (horizontal) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < _steps.length; i++) ...[
                      Expanded(child: _StepNode(step: _steps[i])),
                      if (i < _steps.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.accentBlue.withValues(alpha: 0.5),
                            size: 22,
                          ),
                        ),
                    ],
                  ],
                );
              }
              return Column(
                children: [
                  for (final s in _steps) ...[
                    _StepNode(step: s),
                    const SizedBox(height: 12),
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

class _StepNode extends StatelessWidget {
  const _StepNode({required this.step});
  final (String, String, String) step;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.$1,
            style: const TextStyle(
              color: AppColors.accentBlue,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.$2,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.$3,
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.45,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
