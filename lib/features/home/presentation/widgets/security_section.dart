import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  static const _items = <(IconData, String, String)>[
    (
      Icons.admin_panel_settings_outlined,
      'Role Based Permissions',
      'Least-privilege access for admins, staff, parents and students.',
    ),
    (
      Icons.lock_outline,
      'Encrypted Data',
      'Transport encryption and secure handling of sensitive institutional data.',
    ),
    (
      Icons.backup_outlined,
      'Cloud Backup',
      'Cloud-oriented backup practices for operational continuity.',
    ),
    (
      Icons.verified_user_outlined,
      'Secure Authentication',
      'Modern authentication flows for product and portal access.',
    ),
    (
      Icons.rule_folder_outlined,
      'Access Control',
      'Tenant-aware boundaries designed into multi-campus architecture.',
    ),
    (
      Icons.schedule_outlined,
      'Daily Backup',
      'Regular backup discipline as part of production operations.',
    ),
    (
      Icons.history_edu_outlined,
      'Audit Logs',
      'Traceable operational activity for accountability and support.',
    ),
    (
      Icons.gavel_outlined,
      'Future DPDP Ready',
      'Designed with data-protection readiness for India’s regulatory direction.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Security',
              title: 'Enterprise-minded security by design',
              subtitle:
                  'Security is part of product architecture — not an afterthought for schools and businesses.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1000
                  ? 4
                  : c.maxWidth >= 640
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 1 ? 2.8 : 1.2,
                ),
                itemBuilder: (context, i) {
                  final item = _items[i];
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.borderLight),
                      boxShadow: AppShadows.soft,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(item.$1, color: AppColors.accentBlue),
                        const SizedBox(height: 12),
                        Text(
                          item.$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.brandNavy,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            item.$3,
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
