import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Real product strengths — no fake statistics.
class WhyChooseAsoltuTechSection extends StatelessWidget {
  const WhyChooseAsoltuTechSection({super.key});

  static const _points = <(IconData, String, String)>[
    (
      Icons.flutter_dash,
      'Modern Flutter Architecture',
      'One codebase for web, Android and iOS with polished, consistent experiences.',
    ),
    (
      Icons.auto_awesome,
      'AI Ready Platform',
      'Designed for intelligent reports, insights and automation as your needs grow.',
    ),
    (
      Icons.cloud_done_outlined,
      'Secure Cloud Infrastructure',
      'Cloud-hosted systems with secure authentication and operational safeguards.',
    ),
    (
      Icons.account_tree_outlined,
      'Scalable Architecture',
      'Multi-tenant patterns that grow from a single campus to education groups.',
    ),
    (
      Icons.rocket_launch_outlined,
      'Fast Deployment',
      'Modular rollouts so institutions can go live by priority, not all-or-nothing.',
    ),
    (
      Icons.devices_outlined,
      'Cross Platform Software',
      'Admin, teacher, parent and student experiences across devices and screens.',
    ),
    (
      Icons.offline_bolt_outlined,
      'Offline Ready Modules',
      'Critical workflows designed to stay productive when connectivity is imperfect.',
    ),
    (
      Icons.system_update_alt_outlined,
      'Regular Updates',
      'Continuous product improvements based on real operational feedback.',
    ),
    (
      Icons.support_agent_outlined,
      'Dedicated Technical Support',
      'Direct access to the team that builds and understands the product deeply.',
    ),
    (
      Icons.security_outlined,
      'Enterprise Grade Security',
      'Security-minded engineering for institutional and student data protection.',
    ),
    (
      Icons.admin_panel_settings_outlined,
      'Role Based Access',
      'Fine-grained permissions for admins, teachers, parents and operational staff.',
    ),
    (
      Icons.design_services_outlined,
      'Thoughtful Product Design',
      'Clean interfaces operators can learn quickly without sacrificing power.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Why choose ASOLTU',
              title: 'Real strengths. No inflated claims.',
              subtitle:
                  'Early-stage software company. Modern engineering. Transparent capabilities you can evaluate in a demo.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1100
                  ? 3
                  : c.maxWidth >= 700
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _points.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 1 ? 2.8 : 1.45,
                ),
                itemBuilder: (context, i) {
                  final p = _points[i];
                  return _WhyCard(
                    icon: p.$1,
                    title: p.$2,
                    description: p.$3,
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

class _WhyCard extends StatefulWidget {
  const _WhyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  State<_WhyCard> createState() => _WhyCardState();
}

class _WhyCardState extends State<_WhyCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered
                ? AppColors.accentBlue.withValues(alpha: 0.3)
                : AppColors.borderLight,
          ),
          boxShadow: _hovered ? AppShadows.hover : AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentBlue.withValues(alpha: 0.15),
                    AppColors.accentBlue.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(widget.icon, color: AppColors.accentBlue, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandNavy,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.45,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
