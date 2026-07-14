import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';

class SolutionsPage extends StatelessWidget {
  const SolutionsPage({super.key});

  static const _solutions = <_Solution>[
    _Solution(
      Icons.school_outlined,
      'Schools',
      'K–12 day schools that need reliable daily operations and parent trust.',
      [
        'Attendance marked inconsistently across classes',
        'Fee collection tracked in spreadsheets',
        'Parents call the office for every update',
        'Exam results delayed by manual entry',
      ],
      [
        'Unified attendance with history and alerts',
        'Structured fees, invoices, and receipts',
        'Parent app for fees, attendance, and notices',
        'Examination workflows with report-ready outputs',
      ],
    ),
    _Solution(
      Icons.menu_book_outlined,
      'Coaching Institutes',
      'High-volume institutes with batch throughput and rapid fee cycles.',
      [
        'Enquiries lost between counselors',
        'Batch schedules hard to coordinate',
        'Collections lag without clear dues views',
        'Staff updates scatter across chats',
      ],
      [
        'Enquiry-to-enrollment visibility',
        'Batch-oriented operational structure',
        'Finance clarity for coaching fee cycles',
        'Role-based staff coordination',
      ],
    ),
    _Solution(
      Icons.account_balance_outlined,
      'Colleges',
      'Campuses with departments, assessments, and multi-role administration.',
      [
        'Department data lives in silos',
        'Assessment cycles are error-prone',
        'Access rights are too broad',
        'Leadership lacks timely operational views',
      ],
      [
        'Department-aware structures',
        'Exams and results workflows',
        'RBAC for admin and faculty roles',
        'Leadership-ready operational summaries',
      ],
    ),
    _Solution(
      Icons.apartment_outlined,
      'Education Groups',
      'Multi-campus and multi-brand networks that need central visibility.',
      [
        'Each campus runs a different tool stack',
        'Group leaders cannot compare campuses',
        'Policy templates are reinvented every term',
        'Data boundaries feel unclear',
      ],
      [
        'Multi-tenant multi-campus model',
        'Cross-campus KPIs and reporting',
        'Standardized module playbooks',
        'Isolation by design for institution data',
      ],
    ),
    _Solution(
      Icons.public_outlined,
      'International Schools',
      'Institutions needing polished parent experience and operational discipline.',
      [
        'Families expect transparent digital status',
        'Multiple stakeholder roles create access risk',
        'Reporting must feel premium and timely',
        'Fragmented tools hurt brand trust',
      ],
      [
        'Premium parent and staff experiences',
        'Fine-grained role-based access',
        'Clear operational reporting',
        'One coherent brand-aligned platform',
      ],
    ),
    _Solution(
      Icons.hub_outlined,
      'Smart Campuses',
      'Campuses modernizing with connected modules and intelligent insights.',
      [
        'Point solutions do not share context',
        'Leaders drown in raw dashboards',
        'Automation is partial and fragile',
        'Change management lacks a single narrative',
      ],
      [
        'Connected academics, finance, and ops',
        'AI-assisted leadership summaries',
        'Modular rollout by priority',
        'Clear implementation story for staff',
      ],
    ),
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
                PageBreadcrumb(current: 'Solutions'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'Solutions',
                  title: 'Built for how education institutions actually run',
                  subtitle:
                      'Each solution maps real campus problems to ASOLTU capabilities — so evaluation teams can see fit immediately.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        for (var i = 0; i < _solutions.length; i++)
          PageSection(
            backgroundColor: i.isOdd ? AppColors.surfaceMuted : null,
            child: _SolutionBlock(solution: _solutions[i], index: i),
          ),
        PageSection(
          child: Column(
            children: [
              Text(
                'Not sure which solution fits?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Book a discovery call — we map ASOLTU to your campuses, roles, and fee cycles.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  AsoltuButton(
                    label: 'Book Live Demo',
                    onPressed: () => showBookDemoDialog(context),
                  ),
                  AsoltuButton(
                    label: 'Contact Sales',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.contact),
                  ),
                  AsoltuButton(
                    label: 'View Products',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.products),
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

class _Solution {
  const _Solution(
    this.icon,
    this.title,
    this.subtitle,
    this.problems,
    this.solutions,
  );

  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> problems;
  final List<String> solutions;
}

class _SolutionBlock extends StatelessWidget {
  const _SolutionBlock({required this.solution, required this.index});
  final _Solution solution;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(solution.icon, color: AppColors.accentBlue),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solution.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.brandNavy,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(solution.subtitle),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 860;
            final problems = _CompareCard(
              title: 'Common problems',
              color: const Color(0xFFFFF5F5),
              border: const Color(0xFFFFD0D0),
              icon: Icons.warning_amber_rounded,
              iconColor: AppColors.error,
              items: solution.problems,
            );
            final asoltu = _CompareCard(
              title: 'ASOLTU solution',
              color: const Color(0xFFF3FAF6),
              border: const Color(0xFFBFE8CF),
              icon: Icons.verified_rounded,
              iconColor: AppColors.success,
              items: solution.solutions,
            );
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: problems),
                  const SizedBox(width: 16),
                  Expanded(child: asoltu),
                ],
              );
            }
            return Column(
              children: [
                problems,
                const SizedBox(height: 12),
                asoltu,
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: AsoltuButton(
            label: 'Discuss ${solution.title}',
            variant: AsoltuButtonVariant.secondary,
            onPressed: () => context.go(AppRoutes.contact),
          ),
        ),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.color,
    required this.border,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  final String title;
  final Color color;
  final Color border;
  final IconData icon;
  final Color iconColor;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 8, color: iconColor),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item, style: const TextStyle(height: 1.4))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
