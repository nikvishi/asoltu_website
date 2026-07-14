import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = <(IconData, String, String)>[
    (Icons.person_add_alt_1_outlined, 'Admissions', 'Digital enquiries, applications, and onboarding in one flow.'),
    (Icons.fact_check_outlined, 'Attendance', 'Live student & staff attendance with instant parent alerts.'),
    (Icons.payments_outlined, 'Fees', 'Fee structures, collection, receipts, and automated reminders.'),
    (Icons.assignment_outlined, 'Exams', 'Assessments, marks, results, and report cards at scale.'),
    (Icons.home_work_outlined, 'Homework', 'Assignments, submissions, and classroom follow-ups.'),
    (Icons.directions_bus_outlined, 'Transport', 'Routes, vehicles, and passenger operations.'),
    (Icons.local_library_outlined, 'Library', 'Catalog, issue/return, and overdue tracking.'),
    (Icons.badge_outlined, 'HR', 'Staff records, leave, and people operations.'),
    (Icons.account_balance_wallet_outlined, 'Payroll', 'Salary processing and compliance-ready payouts.'),
    (Icons.auto_awesome, 'AI Reports', 'Intelligent summaries for academics and operations.'),
    (Icons.family_restroom, 'Parent App', 'Fees, attendance, results, and school updates.'),
    (Icons.forum_outlined, 'Communication', 'Announcements, chat, and multi-channel messaging.'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Features',
              title: 'Everything your institution needs',
              subtitle:
                  'Twelve core modules designed for daily school operations — clean, connected, and enterprise-ready.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1100
                  ? 4
                  : c.maxWidth >= 800
                      ? 3
                      : c.maxWidth >= 560
                          ? 2
                          : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 2.5 : 1.12,
                ),
                itemBuilder: (context, i) {
                  final f = _features[i];
                  return _FeatureCard(
                    icon: f.$1,
                    title: f.$2,
                    description: f.$3,
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

class _FeatureCard extends StatefulWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered
                ? AppColors.accentBlue.withValues(alpha: 0.35)
                : AppColors.borderLight,
          ),
          boxShadow: _hovered ? AppShadows.hover : AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(
                  alpha: _hovered ? 0.14 : 0.09,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: AppColors.accentBlue, size: 22),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
