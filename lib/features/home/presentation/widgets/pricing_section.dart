import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Pricing',
              title: 'Simple plans for every school',
              subtitle:
                  'Start lean, scale confidently. Custom enterprise options for large groups.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 980;
              final cards = [
                _PricingCard(
                  name: 'Starter',
                  price: 'Free',
                  period: 'for evaluation',
                  description: 'Perfect for pilots and small campuses.',
                  features: const [
                    'Core academics modules',
                    'Attendance & basic fees',
                    'Parent notifications',
                    'Email support',
                  ],
                  cta: 'Start Free Demo',
                  highlighted: false,
                  onCta: () => launchUrl(
                    Uri.parse(AppUrls.erpPortal),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                _PricingCard(
                  name: 'Professional',
                  price: 'Custom',
                  period: 'per campus / year',
                  description: 'Full operations for growing schools.',
                  features: const [
                    'All Starter features',
                    'Exams, library, transport',
                    'HR & payroll essentials',
                    'AI reports & analytics',
                    'Priority support',
                  ],
                  cta: 'Book Live Demo',
                  highlighted: true,
                  onCta: () => context.go(AppRoutes.contact),
                ),
                _PricingCard(
                  name: 'Enterprise',
                  price: 'Talk to us',
                  period: 'multi-campus groups',
                  description: 'Governance, scale, and dedicated success.',
                  features: const [
                    'Everything in Professional',
                    'Multi-tenant control plane',
                    'Custom SLAs & onboarding',
                    'SSO & advanced security',
                    'Dedicated success manager',
                  ],
                  cta: 'Contact Sales',
                  highlighted: false,
                  onCta: () => context.go(AppRoutes.contact),
                ),
              ];

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      Expanded(child: cards[i]),
                      if (i < cards.length - 1) const SizedBox(width: 16),
                    ],
                  ],
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    cards[i],
                    if (i < cards.length - 1) const SizedBox(height: 16),
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

class _PricingCard extends StatefulWidget {
  const _PricingCard({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.cta,
    required this.highlighted,
    required this.onCta,
  });

  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final String cta;
  final bool highlighted;
  final VoidCallback onCta;

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
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
            color: widget.highlighted
                ? AppColors.accentBlue.withValues(alpha: 0.55)
                : AppColors.borderLight,
            width: widget.highlighted ? 1.6 : 1,
          ),
          boxShadow: widget.highlighted || _hovered
              ? AppShadows.hover
              : AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.highlighted)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: const Text(
                  'MOST POPULAR',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accentGoldDark,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.price,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.accentBlue,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              widget.period,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 12),
            Text(widget.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 18),
            for (final f in widget.features)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        f,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 18),
            AsoltuButton(
              label: widget.cta,
              expanded: true,
              variant: widget.highlighted
                  ? AsoltuButtonVariant.primary
                  : AsoltuButtonVariant.secondary,
              onPressed: widget.onCta,
            ),
          ],
        ),
      ),
    );
  }
}
