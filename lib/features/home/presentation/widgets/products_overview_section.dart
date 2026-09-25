import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Company product suite cards for the homepage.
class ProductsOverviewSection extends StatelessWidget {
  const ProductsOverviewSection({super.key});

  static const _products = <(IconData, String, String, String)>[
    (
      Icons.school_outlined,
      'School ERP',
      'Complete school operations — admissions, academics, fees, HR and parent apps on one secure platform.',
      '/modules/school-erp',
    ),
    (
      Icons.auto_awesome,
      'AI Solutions',
      'AI-assisted reports, operational insights and intelligent automation for education and business teams.',
      '/services/ai-development',
    ),
    (
      Icons.phone_iphone_rounded,
      'Mobile Apps',
      'Flutter-powered Android and iOS apps for parents, teachers, students and field operations.',
      '/services/mobile-app-development-company',
    ),
    (
      Icons.language_rounded,
      'Website Development',
      'Modern, responsive websites and portals designed for performance, SEO and conversion.',
      '/services/website-development',
    ),
    (
      Icons.cloud_outlined,
      'Cloud Solutions',
      'Secure cloud infrastructure, deployment, storage and messaging for scalable software products.',
      '/services/cloud-solutions',
    ),
    (
      Icons.apartment_outlined,
      'Enterprise Software',
      'Custom enterprise systems with role-based access, auditability and multi-tenant architecture.',
      '/services/custom-software-development',
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
              eyebrow: 'What we build',
              title: 'Intelligent software for modern organizations',
              subtitle:
                  'From flagship School ERP to AI, mobile, web, cloud and enterprise systems — engineered with Flutter and cloud technologies.',
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
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 2.6 : 1.25,
                ),
                itemBuilder: (context, i) {
                  final p = _products[i];
                  return _ProductCard(
                    icon: p.$1,
                    title: p.$2,
                    description: p.$3,
                    onLearnMore: () => context.go(p.$4),
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

class _ProductCard extends StatefulWidget {
  const _ProductCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onLearnMore,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onLearnMore;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
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
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(widget.icon, color: AppColors.accentBlue),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.brandNavy,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: widget.onLearnMore,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentBlue,
                padding: EdgeInsets.zero,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn More',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
