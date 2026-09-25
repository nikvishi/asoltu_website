import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = <(IconData, String, String)>[
    (Icons.person_add_alt_1_outlined, 'Admissions', 'Enquiries, applications and enrollment in one flow.'),
    (Icons.fact_check_outlined, 'Attendance', 'Student and staff attendance with history and alerts.'),
    (Icons.payments_outlined, 'Fees', 'Structures, collection, receipts and reminders.'),
    (Icons.account_balance_wallet_outlined, 'Payroll', 'Salary processing and payout workflows.'),
    (Icons.badge_outlined, 'HR', 'Staff records, leave and people operations.'),
    (Icons.local_library_outlined, 'Library', 'Catalog, issue/return and overdue tracking.'),
    (Icons.directions_bus_outlined, 'Transport', 'Routes, vehicles and passenger operations.'),
    (Icons.inventory_2_outlined, 'Inventory', 'Campus inventory and stock visibility.'),
    (Icons.calendar_view_week_outlined, 'Timetable', 'Class schedules and period planning.'),
    (Icons.assignment_outlined, 'Examinations', 'Assessments, marks, results and report cards.'),
    (Icons.home_work_outlined, 'Homework', 'Assignments, submissions and follow-ups.'),
    (Icons.auto_awesome, 'AI Reports', 'Intelligent summaries for academics and operations.'),
    (Icons.family_restroom, 'Parent App', 'Fees, attendance, results and school updates.'),
    (Icons.person_outline, 'Teacher App', 'Attendance, homework, results and class tools.'),
    (Icons.backpack_outlined, 'Student App', 'Timetable, results, homework and library status.'),
    (Icons.dashboard_outlined, 'Admin Dashboard', 'Leadership views across campus operations.'),
    (Icons.how_to_reg_outlined, 'Visitor Management', 'Campus visitor logging and control.'),
    (Icons.hotel_outlined, 'Hostel', 'Room allocation and residential workflows.'),
    (Icons.fingerprint, 'Biometric', 'Biometric-ready attendance integrations.'),
    (Icons.forum_outlined, 'Communication', 'Announcements and multi-channel messaging.'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'School ERP modules',
              title: 'Everything your institution needs',
              subtitle:
                  'Twenty connected modules for daily school administration — from admissions and fees to parent apps and AI reports.',
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
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 1 ? 2.6 : 1.15,
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
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(20),
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accentBlue
                    : AppColors.accentBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                widget.icon,
                size: 20,
                color: _hovered ? Colors.white : AppColors.accentBlue,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.brandNavy,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                widget.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.45,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
