import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _values = [
    (Icons.favorite_outline, 'Student-first', 'Every workflow should improve learning outcomes and institutional trust.'),
    (Icons.verified_user_outlined, 'Reliability', 'Schools run daily — uptime, accuracy, and clear audit trails are non-negotiable.'),
    (Icons.auto_fix_high_outlined, 'Clarity', 'Complex campus operations deserve simple, beautiful software.'),
    (Icons.security_outlined, 'Security', 'Multi-tenant isolation and role-based access by design.'),
    (Icons.handshake_outlined, 'Partnership', 'We implement with operators — principals, accountants, and teachers.'),
    (Icons.trending_up, 'Craft', 'Ship carefully, measure impact, and refine from real campus feedback.'),
  ];

  static const _timeline = [
    ('2023', 'Vision', 'ASOLTU formed to replace spreadsheet-heavy school operations with a unified platform.'),
    ('2024', 'Core ERP', 'Core modules and multi-role portals for academics, fees, and attendance.'),
    ('2025', 'SaaS foundation', 'Multi-tenant architecture, AI reporting foundations, production hardening.'),
    ('2026', 'Scale readiness', 'Enterprise onboarding readiness and a world-class marketing experience for evaluators.'),
  ];

  static const _why = [
    'Education-first product design — not a generic ERP with school labels',
    'Connected modules so finance, academics, and parents share one truth',
    'Role-based experiences for admins, teachers, parents, and students',
    'Multi-campus isolation for groups that need both control and autonomy',
    'AI summaries that help leaders decide, not just visualize',
    'Implementation mindset that respects academic calendars',
  ];

  static const _stack = [
    'Flutter Web & Mobile',
    'Firebase Auth',
    'Cloud Firestore',
    'Material 3',
    'AI-assisted reporting',
    'Multi-tenant architecture',
    'Role-based access control',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 16),
          child: const FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: 'About'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'About ASOLTU',
                  title: 'Software schools trust every day',
                  subtitle:
                      'ASOLTU Tech Solutions builds the operating system for modern institutions — so leaders spend time on students, not spreadsheets.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 900;
              final mission = _card(
                context,
                'Mission',
                'Make school management simple, secure, and intelligent for every campus size — single schools through multi-brand education groups.',
              );
              final vision = _card(
                context,
                'Vision',
                'A world where education leaders run transparent operations, parents stay informed, and staff collaborate on one trusted platform.',
              );
              if (wide) {
                return Row(
                  children: [
                    Expanded(child: mission),
                    const SizedBox(width: 16),
                    Expanded(child: vision),
                  ],
                );
              }
              return Column(children: [mission, const SizedBox(height: 16), vision]);
            },
          ),
        ),
        PageSection(
          child: const SectionHeading(
            eyebrow: 'Our story',
            title: 'Built with operators in mind',
            subtitle:
                'ASOLTU is shaped by real campus complexity: multi-role access, fee cycles, attendance discipline, parent trust, and the need for one system of record. We design for principals, accountants, teachers, and parents — not only for IT checklists. Our philosophy is simple: software should disappear into reliable daily rhythm.',
            center: true,
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Timeline',
                title: 'Company journey',
                center: true,
              ),
              const SizedBox(height: 24),
              for (final t in _timeline)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          t.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.accentBlue,
                          ),
                        ),
                      ),
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
                            const SizedBox(height: 4),
                            Text(t.$3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Values',
                title: 'What we stand for',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 1000 ? 3 : c.maxWidth >= 640 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _values.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: cols == 1 ? 2.5 : 1.3,
                    ),
                    itemBuilder: (context, i) {
                      final v = _values[i];
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
                            Icon(v.$1, color: AppColors.accentBlue),
                            const SizedBox(height: 12),
                            Text(
                              v.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandNavy,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(child: Text(v.$3)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Why ASOLTU',
                title: 'Different by design',
                center: true,
              ),
              const SizedBox(height: 20),
              for (final w in _why)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.success, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text(w)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Leadership philosophy',
                title: 'Operators first. Technology second.',
                subtitle:
                    'We believe great education software is led by empathy for campus operators. Product decisions start with principal workflows, fee-cycle realities, teacher time, and parent trust — then we engineer for multi-tenant security, performance, and clarity. We do not invent fake personas; we build for real institutions.',
                center: true,
              ),
              const SizedBox(height: 28),
              const SectionHeading(
                eyebrow: 'Technology',
                title: 'Modern stack. Enterprise discipline.',
                center: true,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (final s in _stack)
                    Chip(
                      label: Text(s),
                      backgroundColor: AppColors.surfaceMuted,
                      side: const BorderSide(color: AppColors.borderLight),
                    ),
                ],
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  AsoltuButton(
                    label: 'Contact us',
                    onPressed: () => context.go(AppRoutes.contact),
                  ),
                  AsoltuButton(
                    label: 'Careers',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.careers),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card(BuildContext context, String title, String body) {
    return Container(
      width: double.infinity,
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
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(body, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
