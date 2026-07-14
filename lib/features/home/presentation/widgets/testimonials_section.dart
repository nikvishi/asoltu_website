import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _items = [
    (
      'Principal',
      'Dr. Meera Kapoor',
      'Greenfield Public School',
      'ASOLTU unified our multi-campus operations. Attendance, fees, and board reporting finally live in one place.',
    ),
    (
      'Teacher',
      'Rahul Iyer',
      'Horizon International',
      'Homework, results, and parent updates are simple. The teacher portal saves our staff hours every week.',
    ),
    (
      'Administrator',
      'Sana Qureshi',
      'EduPath Group',
      'Payroll, admissions, and analytics left spreadsheets behind. Onboarding was smooth and professional.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Testimonials',
              title: 'Trusted by school teams',
              subtitle:
                  'What school leaders, teachers, and administrators value when operations finally live in one platform.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 960
                  ? 3
                  : c.maxWidth >= 640
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 1.45 : 0.95,
                ),
                itemBuilder: (context, i) {
                  final t = _items[i];
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.borderLight),
                      boxShadow: AppShadows.soft,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (_) => const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: AppColors.accentGold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: Text(
                            '“${t.$4}”',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.55,
                                ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  AppColors.accentBlue.withValues(alpha: 0.12),
                              child: Text(
                                t.$2.isNotEmpty ? t.$2[0] : 'A',
                                style: const TextStyle(
                                  color: AppColors.accentBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.$2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.brandNavy,
                                    ),
                                  ),
                                  Text(
                                    '${t.$1} · ${t.$3}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
