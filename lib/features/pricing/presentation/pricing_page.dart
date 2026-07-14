import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';
import '../../home/presentation/widgets/faq_section.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  static const _plans = [
    (
      'Starter',
      'Free',
      'Evaluation',
      false,
      [
        'Core academics',
        'Attendance',
        'Basic fees',
        'Parent notifications',
        'Email support',
      ],
    ),
    (
      'Professional',
      'Custom',
      'Per campus / year',
      true,
      [
        'Everything in Starter',
        'Exams, library, transport',
        'HR essentials',
        'AI reports',
        'Priority support',
      ],
    ),
    (
      'Enterprise',
      'Custom',
      'Institution-wide',
      false,
      [
        'Everything in Professional',
        'Advanced security',
        'Custom SLAs',
        'SSO options',
        'Dedicated success',
      ],
    ),
    (
      'Education Group',
      'Talk to sales',
      'Multi-brand / multi-tenant',
      false,
      [
        'Group control plane',
        'Centralized billing',
        'Cross-campus analytics',
        'White-label options',
        'Executive reporting',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 48, 0, 16),
          child: const FadeIn(
            child: SectionHeading(
              eyebrow: 'Pricing',
              title: 'Transparent plans that scale with you',
              subtitle:
                  'Start free, grow into Professional, or run a full education group on Enterprise.',
              center: true,
            ),
          ),
        ),
        PageSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1100
                  ? 4
                  : c.maxWidth >= 800
                      ? 2
                      : 1;
              if (cols == 1) {
                return Column(
                  children: [
                    for (final p in _plans) ...[
                      _PlanCard(
                        name: p.$1,
                        price: p.$2,
                        period: p.$3,
                        highlighted: p.$4,
                        features: p.$5,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              }
              final rows = <Widget>[];
              for (var i = 0; i < _plans.length; i += cols) {
                rows.add(
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i + cols < _plans.length ? 16 : 0,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var j = 0; j < cols; j++) ...[
                            if (j > 0) const SizedBox(width: 16),
                            Expanded(
                              child: i + j < _plans.length
                                  ? _PlanCard(
                                      name: _plans[i + j].$1,
                                      price: _plans[i + j].$2,
                                      period: _plans[i + j].$3,
                                      highlighted: _plans[i + j].$4,
                                      features: _plans[i + j].$5,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Column(children: rows);
            },
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Compare',
                title: 'Feature comparison',
                center: true,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: AppShadows.soft,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 640),
                    child: const SizedBox(
                      width: 720,
                      child: Column(
                        children: [
                          _CompareHeader(),
                          Divider(height: 24),
                          _CompareRow(
                            'Modules',
                            'Core',
                            'Full suite',
                            'Full + custom',
                            'Group + custom',
                          ),
                          _CompareRow(
                            'AI Reports',
                            '—',
                            'Yes',
                            'Yes',
                            'Yes + executive',
                          ),
                          _CompareRow(
                            'Multi-campus',
                            '—',
                            'Limited',
                            'Yes',
                            'Native group',
                          ),
                          _CompareRow(
                            'SSO / SLA',
                            '—',
                            '—',
                            'Yes',
                            'Yes',
                          ),
                          _CompareRow(
                            'Support',
                            'Email',
                            'Priority',
                            'Dedicated',
                            'Dedicated + CSM',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const FaqSection(),
        PageSection(
          child: Column(
            children: [
              Text(
                'Need a custom quote for your group?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  AsoltuButton(
                    label: 'Contact Sales',
                    onPressed: () => context.go(AppRoutes.contact),
                  ),
                  AsoltuButton(
                    label: 'Start Free Demo',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => launchUrl(
                      Uri.parse(AppUrls.erpPortal),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanCard extends StatefulWidget {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.highlighted,
    required this.features,
  });

  final String name;
  final String price;
  final String period;
  final bool highlighted;
  final List<String> features;

  @override
  State<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<_PlanCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        transform: Matrix4.translationValues(0, _h ? -4 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: widget.highlighted
                ? AppColors.accentBlue.withValues(alpha: 0.5)
                : AppColors.borderLight,
            width: widget.highlighted ? 1.6 : 1,
          ),
          boxShadow: widget.highlighted || _h ? AppShadows.hover : AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.highlighted)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accentGoldDark,
                  ),
                ),
              ),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.brandNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.price,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: AppColors.accentBlue,
              ),
            ),
            Text(
              widget.period,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 16),
            for (final f in widget.features)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        size: 16, color: AppColors.success),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: const TextStyle(fontSize: 13))),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            AsoltuButton(
              label: widget.name == 'Starter' ? 'Start Free' : 'Talk to sales',
              expanded: true,
              variant: widget.highlighted
                  ? AsoltuButtonVariant.primary
                  : AsoltuButtonVariant.secondary,
              onPressed: () {
                if (widget.name == 'Starter') {
                  launchUrl(
                    Uri.parse(AppUrls.erpPortal),
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  context.go(AppRoutes.contact);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CompareHeader extends StatelessWidget {
  const _CompareHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Feature',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.brandNavy),
          ),
        ),
        Expanded(child: Text('Starter', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700))),
        Expanded(child: Text('Pro', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700))),
        Expanded(child: Text('Enterprise', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700))),
        Expanded(child: Text('Edu Group', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700))),
      ],
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow(this.feature, this.a, this.b, this.c, this.d);
  final String feature;
  final String a;
  final String b;
  final String c;
  final String d;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.brandNavy,
              ),
            ),
          ),
          Expanded(child: Text(a, textAlign: TextAlign.center)),
          Expanded(child: Text(b, textAlign: TextAlign.center)),
          Expanded(child: Text(c, textAlign: TextAlign.center)),
          Expanded(child: Text(d, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
