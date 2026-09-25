import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Company-wide technology services (Asoltu Tech).
/// Placed after Hero — does not replace School ERP product focus.
class TechnologySolutionsSection extends StatelessWidget {
  const TechnologySolutionsSection({super.key});

  static const _services = <(IconData, String, String)>[
    (
      Icons.code_rounded,
      'Software Development',
      'Custom Software for Businesses',
    ),
    (
      Icons.language_rounded,
      'Web Development',
      'Modern Responsive Websites & Portals',
    ),
    (
      Icons.phone_iphone_rounded,
      'Mobile App Development',
      'Android • iOS • Flutter',
    ),
    (
      Icons.cloud_outlined,
      'Cloud Solutions',
      'Cloud Infrastructure & Deployment',
    ),
    (
      Icons.storage_rounded,
      'Database Solutions',
      'Database Design & Migration',
    ),
    (
      Icons.security_rounded,
      'Cyber Security',
      'Secure & Reliable Systems',
    ),
    (
      Icons.auto_awesome,
      'AI & Automation',
      'AI Integration & Business Automation',
    ),
    (
      Icons.design_services_outlined,
      'UI/UX Design',
      'Modern User Experience',
    ),
    (
      Icons.support_agent_rounded,
      'IT Support & Maintenance',
      'AMC & Technical Support',
    ),
    (
      Icons.school_outlined,
      'IT Training & Consulting',
      'Professional Technology Consulting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Asoltu Tech',
              title: 'Our Technology Solutions',
              subtitle:
                  'Software development company India services: web development, Flutter mobile apps, '
                  'cloud solutions, AI automation, cyber security and IT consulting — plus School ERP '
                  'for education institutions and business software for growing organizations.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1100
                  ? 3
                  : c.maxWidth >= 720
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 3.2 : 1.55,
                ),
                itemBuilder: (context, i) {
                  final s = _services[i];
                  return _ServiceCard(
                    icon: s.$1,
                    title: s.$2,
                    description: s.$3,
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

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered
                ? AppColors.brandNavy.withValues(alpha: 0.22)
                : AppColors.borderLight,
          ),
          boxShadow: _hovered ? AppShadows.elevated : AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accentBlue.withValues(alpha: 0.12)
                    : AppColors.brandNavy.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                widget.icon,
                color: _hovered ? AppColors.accentBlue : AppColors.brandNavy,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.brandNavy,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium,
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
