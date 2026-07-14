import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    (1, 'Create School', 'Set up your institution, campuses, and academic year.'),
    (2, 'Add Staff', 'Invite admins, teachers, and operational roles.'),
    (3, 'Add Students', 'Import or enroll students with class structure.'),
    (4, 'Start Managing', 'Run attendance, fees, academics, and communication.'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'How it works',
              title: 'Go live in four simple steps',
              subtitle:
                  'A guided onboarding path designed for school leadership and IT teams.',
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
                      Expanded(child: _StepCard(step: _steps[i])),
                      if (i < _steps.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.accentBlue.withValues(alpha: 0.55),
                          ),
                        ),
                    ],
                  ],
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < _steps.length; i++) ...[
                    _StepCard(step: _steps[i]),
                    if (i < _steps.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: AppColors.accentBlue.withValues(alpha: 0.55),
                        ),
                      ),
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

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final (int, String, String) step;

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
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              '${step.$1}',
              style: const TextStyle(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            step.$2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            step.$3,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
