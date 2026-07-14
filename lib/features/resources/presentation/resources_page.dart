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

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hub = <(IconData, String, String, VoidCallback)>[
      (Icons.hub_outlined, 'Knowledge Hub', 'Central entry for guides, docs, and FAQs.', () => context.go(AppRoutes.documentation)),
      (Icons.menu_book_outlined, 'Guides', 'Playbooks for fees, attendance, and rollouts.', () => context.go(AppRoutes.blog)),
      (Icons.description_outlined, 'Documentation', 'Implementation topics for go-live teams.', () => context.go(AppRoutes.documentation)),
      (Icons.download_outlined, 'Downloads', 'Evaluation packs for leadership review.', () => launchUrl(Uri.parse(AppUrls.salesEmail))),
      (Icons.help_outline, 'FAQ', 'Answers evaluators and operators ask most.', () => context.go(AppRoutes.support)),
      (Icons.history_edu_outlined, 'Release Notes', 'What shipped for campuses and partners.', () => context.go(AppRoutes.resources)),
      (Icons.cases_outlined, 'Case Studies', 'Outcomes patterns for institution types.', () => context.go(AppRoutes.solutions)),
      (Icons.play_circle_outline, 'Videos', 'Walkthroughs for leadership and finance.', () => showBookDemoDialog(context)),
      (Icons.rocket_launch_outlined, 'Getting Started', 'First-week checklist for new campuses.', () => context.go(AppRoutes.documentation)),
    ];

    final downloads = [
      ('Product one-pager', 'Board-ready overview of ASOLTU School ERP.', 'PDF'),
      ('Module capability map', 'Full product list for RFP and evaluation.', 'PDF'),
      ('Security overview', 'Multi-tenant isolation and RBAC highlights.', 'PDF'),
      ('Implementation checklist', 'First-week setup for academic year and roles.', 'PDF'),
    ];

    final releases = [
      ('2026.2 · July 2026', 'Marketing site polish, lead capture, demo booking, SEO completeness.'),
      ('2026.1 · Q1 2026', 'Production hardening and multi-tenant enterprise readiness.'),
      ('2025.4 · Q4 2025', 'AI reporting foundations and portal UX depth.'),
      ('2025.2 · Mid 2025', 'Core academics, fees, attendance, and role portals expanded.'),
    ];

    final cases = [
      ('Day school operations', 'Attendance + fees + parent app as the trust trio for K–12 campuses.'),
      ('Coaching fee cycles', 'How high-volume institutes keep collections visible without spreadsheet risk.'),
      ('Education group visibility', 'Multi-campus KPIs with tenant isolation for group leadership.'),
    ];

    final videos = [
      ('Product overview', 'Platform story for principals and group leaders.'),
      ('Finance walkthrough', 'Fee structures, invoices, and collection health.'),
      ('Parent experience', 'What families see day to day.'),
      ('Teacher portal', 'Attendance, homework, and classroom communication.'),
    ];

    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 16),
          child: const FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: 'Resources'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'Resources',
                  title: 'Knowledge hub for evaluators and operators',
                  subtitle:
                      'Documentation, guides, downloads, release notes, case studies, and getting-started paths — designed for school leaders and IT teams.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        PageSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1000 ? 3 : c.maxWidth >= 640 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hub.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 1 ? 2.3 : 1.25,
                ),
                itemBuilder: (context, i) {
                  final h = hub[i];
                  return _HubCard(
                    icon: h.$1,
                    title: h.$2,
                    body: h.$3,
                    onTap: h.$4,
                  );
                },
              );
            },
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Getting started',
                title: 'Launch sequence for new campuses',
                center: true,
              ),
              const SizedBox(height: 16),
              for (final step in [
                '1. Create school profile and academic year',
                '2. Configure roles and invite staff',
                '3. Set fee structures and class roster foundations',
                '4. Enable attendance and parent notifications',
                '5. Train champions and go live by priority modules',
              ])
                _row(Icons.flag_outlined, step, null),
              const SizedBox(height: 12),
              AsoltuButton(
                label: 'Open documentation',
                onPressed: () => context.go(AppRoutes.documentation),
              ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Downloads',
                title: 'Evaluation materials',
                subtitle: 'Request PDF packs for board review, RFPs, and stakeholder alignment.',
                center: true,
              ),
              const SizedBox(height: 20),
              for (final d in downloads)
                _row(
                  Icons.download_outlined,
                  d.$1,
                  d.$2,
                  trailing: d.$3,
                  action: 'Request',
                  onAction: () => launchUrl(Uri.parse(AppUrls.salesEmail)),
                ),
            ],
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Case studies',
                title: 'Outcome patterns by institution type',
                center: true,
              ),
              const SizedBox(height: 20),
              for (final c in cases)
                _row(Icons.cases_outlined, c.$1, c.$2),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Videos',
                title: 'Walkthroughs for your evaluation team',
                center: true,
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: videos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: cols == 1 ? 2.6 : 2.2,
                    ),
                    itemBuilder: (context, i) {
                      final v = videos[i];
                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: AppShadows.soft,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppRadius.md),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.brandNavy,
                                    AppColors.accentBlue.withValues(alpha: 0.85),
                                  ],
                                ),
                              ),
                              child: const Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 30),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    v.$1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.brandNavy,
                                    ),
                                  ),
                                  Text(v.$2),
                                  TextButton(
                                    onPressed: () => showBookDemoDialog(context),
                                    child: const Text('Schedule live walkthrough →'),
                                  ),
                                ],
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
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Release notes',
                title: 'What shipped',
                center: true,
              ),
              const SizedBox(height: 20),
              for (final r in releases)
                _row(Icons.history_edu_outlined, r.$1, r.$2),
            ],
          ),
        ),
        const FaqSection(),
        PageSection(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              AsoltuButton(
                label: 'Contact Sales',
                onPressed: () => context.go(AppRoutes.contact),
              ),
              AsoltuButton(
                label: 'Open Support',
                variant: AsoltuButtonVariant.secondary,
                onPressed: () => context.go(AppRoutes.support),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(
    IconData icon,
    String title,
    String? body, {
    String? trailing,
    String? action,
    VoidCallback? onAction,
  }) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.accentBlue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.brandNavy,
                      ),
                    ),
                    if (body != null) Text(body),
                  ],
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    trailing,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (action != null && onAction != null)
                AsoltuButton(
                  label: action,
                  variant: AsoltuButtonVariant.secondary,
                  onPressed: onAction,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _HubCard extends StatefulWidget {
  const _HubCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  State<_HubCard> createState() => _HubCardState();
}

class _HubCardState extends State<_HubCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onHover: (v) => setState(() => _h = v),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _h
                  ? AppColors.accentBlue.withValues(alpha: 0.35)
                  : AppColors.borderLight,
            ),
            boxShadow: _h ? AppShadows.hover : AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: AppColors.accentBlue),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.brandNavy,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(child: Text(widget.body)),
              const Text(
                'Open →',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
