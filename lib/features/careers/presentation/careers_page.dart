import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  static const _why = [
    (
      Icons.school_outlined,
      'Mission that matters',
      'Your work improves daily operations for schools, teachers, parents, and students.',
    ),
    (
      Icons.devices_outlined,
      'Modern product craft',
      'Flutter, Material 3, and multi-tenant SaaS patterns used in real production campuses.',
    ),
    (
      Icons.groups_outlined,
      'High ownership',
      'Small teams, clear outcomes, and the chance to shape product direction early.',
    ),
    (
      Icons.public_outlined,
      'Hybrid flexibility',
      'Collaborate with focus — hybrid-friendly culture for deep engineering and GTM work.',
    ),
  ];

  static const _culture = [
    'Clarity over chaos — write it down, ship carefully, measure impact',
    'Respect for operators — principals and accountants are our design partners',
    'Security by default — multi-tenant education data is a privilege',
    'Kind, direct feedback — we grow faster when we are honest',
  ];

  static const _benefits = [
    'Competitive compensation',
    'Learning & conference budget',
    'Flexible hybrid work',
    'Modern Mac / tooling support',
    'Meaningful equity conversations where applicable',
    'Health benefits as role and location allow',
    'Early ownership of product surface area',
    'Mission-driven education impact',
  ];

  static const _roles = [
    (
      'Flutter Engineer',
      'Product · Remote / Hybrid · Full-time',
      'Build polished web and mobile experiences for school administrators, teachers, and parents.',
      ['Flutter / Dart', 'Material 3 UI', 'Performance-minded shipping'],
    ),
    (
      'Backend / Platform Engineer',
      'Platform · Hybrid · Full-time',
      'Scale multi-tenant SaaS foundations, data models, and reliable integrations.',
      ['Cloud backends', 'Security mindset', 'API design'],
    ),
    (
      'Customer Success Manager',
      'GTM · India · Full-time',
      'Onboard schools, drive adoption, and turn live campuses into success stories.',
      ['Education domain', 'Communication', 'Problem solving'],
    ),
    (
      'Sales Associate',
      'GTM · India · Full-time',
      'Help institutions evaluate ASOLTU School ERP and guide commercial conversations.',
      ['Consultative selling', 'CRM hygiene', 'Demo fluency'],
    ),
  ];

  static const _process = [
    ('01', 'Apply', 'Email careers@asoltu.com with role, resume, and a short note on fit.'),
    ('02', 'Screen', 'A conversation about experience, motivation, and collaboration style.'),
    ('03', 'Deep dive', 'Role-specific interview or practical exercise with the team.'),
    ('04', 'Offer', 'Clear next steps, compensation discussion, and onboarding plan.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 24),
          child: FadeIn(
            child: Column(
              children: [
                const PageBreadcrumb(current: 'Careers'),
                const SizedBox(height: 20),
                const SectionHeading(
                  eyebrow: 'Careers',
                  title: 'Build the future of school software',
                  subtitle:
                      'Join ASOLTU Technologies — a team shipping reliable ERP for modern institutions.',
                  center: true,
                ),
                const SizedBox(height: 20),
                AsoltuButton(
                  label: 'Email careers@asoltu.com',
                  onPressed: () => launchUrl(Uri.parse(AppUrls.careersEmail)),
                ),
              ],
            ),
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Why join',
                title: 'Why people choose ASOLTU',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 1000 ? 4 : c.maxWidth >= 640 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _why.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: cols == 1 ? 2.4 : 1.15,
                    ),
                    itemBuilder: (context, i) {
                      final w = _why[i];
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
                            Icon(w.$1, color: AppColors.accentBlue),
                            const SizedBox(height: 12),
                            Text(
                              w.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandNavy,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                w.$3,
                                style: Theme.of(context).textTheme.bodyMedium,
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
        ),
        PageSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 900;
              final culture = _panel(
                context,
                'Culture',
                _culture
                    .map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.spa_outlined,
                                size: 18, color: AppColors.accentBlue),
                            const SizedBox(width: 10),
                            Expanded(child: Text(line)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
              final benefits = _panel(
                context,
                'Benefits',
                _benefits
                    .map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                size: 18, color: AppColors.success),
                            const SizedBox(width: 10),
                            Expanded(child: Text(b)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: culture),
                    const SizedBox(width: 16),
                    Expanded(child: benefits),
                  ],
                );
              }
              return Column(children: [culture, const SizedBox(height: 16), benefits]);
            },
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Open positions',
                title: 'Roles we are hiring for',
                subtitle:
                    'Do not see a perfect match? Write to us anyway — strong generalists are welcome.',
                center: true,
              ),
              const SizedBox(height: 24),
              for (final r in _roles)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: AppShadows.soft,
                  ),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final stack = c.maxWidth < 640;
                      final text = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.$1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AppColors.brandNavy,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.$2,
                            style: const TextStyle(
                              color: AppColors.accentBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(r.$3),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final t in r.$4)
                                Chip(
                                  label: Text(t),
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: AppColors.surfaceMuted,
                                  side: const BorderSide(color: AppColors.borderLight),
                                ),
                            ],
                          ),
                        ],
                      );
                      final btn = AsoltuButton(
                        label: 'Apply',
                        onPressed: () => launchUrl(
                          Uri.parse(
                            '${AppUrls.careersEmail}?subject=${Uri.encodeComponent('Application: ${r.$1}')}',
                          ),
                        ),
                      );
                      if (stack) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [text, const SizedBox(height: 16), btn],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text),
                          const SizedBox(width: 16),
                          btn,
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Hiring process',
                title: 'Simple, respectful, clear',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900 ? 4 : c.maxWidth >= 600 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _process.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: cols == 1 ? 2.5 : 1.2,
                    ),
                    itemBuilder: (context, i) {
                      final p = _process[i];
                      return Container(
                        padding: const EdgeInsets.all(18),
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
                              p.$1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentBlue,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              p.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandNavy,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(child: Text(p.$3)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                'Ready to apply?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              AsoltuButton(
                label: 'Apply via careers@asoltu.com',
                onPressed: () => launchUrl(Uri.parse(AppUrls.careersEmail)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _panel(BuildContext context, String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}
