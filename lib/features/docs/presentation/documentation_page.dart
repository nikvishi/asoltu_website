import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  static const _sections = <(String, String, List<(String, String)>)>[
    (
      'Getting started',
      'Launch your campus on ASOLTU with a clear first-week sequence.',
      [
        (
          'Create your school',
          'School profile, academic year, branding, and basic configuration for a new tenant.',
        ),
        (
          'Roles & invites',
          'Admin, teachers, parents, and student access patterns with least-privilege defaults.',
        ),
        (
          'First-week checklist',
          'Attendance, fee structures, class setup, and parent notification readiness.',
        ),
      ],
    ),
    (
      'Core modules',
      'Day-to-day academic and financial operations.',
      [
        (
          'Admissions',
          'Enquiries through enrollment workflows with status tracking for the admissions team.',
        ),
        (
          'Fees',
          'Structures, invoices, receipts, reminders, and collection health for finance staff.',
        ),
        (
          'Attendance',
          'Marking, reports, history, and parent alerts for students and staff.',
        ),
        (
          'Exams & results',
          'Assessments, marks entry, results publication, and report-card ready outputs.',
        ),
      ],
    ),
    (
      'Operations',
      'Campus services beyond the classroom.',
      [
        (
          'Library & transport',
          'Catalog, issue/return, routes, vehicles, and passenger operations.',
        ),
        (
          'HR & payroll',
          'Staff records, leave, and salary runs aligned to campus calendars.',
        ),
        (
          'Inventory',
          'Stock, purchases, and campus asset tracking for admin teams.',
        ),
        (
          'Hostel',
          'Room allocation and residential workflows for boarding campuses.',
        ),
      ],
    ),
    (
      'Portals & intelligence',
      'Stakeholder experiences and decision support.',
      [
        (
          'Parent app experience',
          'Fees status, attendance, homework, and school notices families can trust.',
        ),
        (
          'Teacher portal',
          'Classroom tools for attendance, homework, results, and communication.',
        ),
        (
          'Student portal',
          'Timetable, results, homework, and library access for learners.',
        ),
        (
          'AI reports',
          'How intelligent summaries are generated from operational data for leaders.',
        ),
      ],
    ),
    (
      'Security & administration',
      'Protect institution data and control access.',
      [
        (
          'Security & RBAC',
          'Roles, permissions, multi-tenant isolation, and operational access patterns.',
        ),
        (
          'Data ownership',
          'Institution data boundaries and how marketing leads stay separate from ERP tenants.',
        ),
        (
          'Multi-campus administration',
          'Patterns for education groups and franchise-style rollouts.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 48, 0, 24),
          child: FadeIn(
            child: Column(
              children: [
                const SectionHeading(
                  eyebrow: 'Documentation',
                  title: 'ASOLTU product documentation',
                  subtitle:
                      'Implementation-oriented guides for administrators, implementers, and campus champions. Browse topics below or contact support for guided help.',
                  center: true,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AsoltuButton(
                      label: 'Contact support',
                      onPressed: () => context.go(AppRoutes.support),
                    ),
                    AsoltuButton(
                      label: 'Book implementation call',
                      variant: AsoltuButtonVariant.secondary,
                      onPressed: () => showBookDemoDialog(context),
                    ),
                    AsoltuButton(
                      label: 'Browse resources',
                      variant: AsoltuButtonVariant.secondary,
                      onPressed: () => context.go(AppRoutes.downloads),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        for (var si = 0; si < _sections.length; si++)
          PageSection(
            backgroundColor: si.isOdd ? AppColors.surfaceMuted : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _sections[si].$1,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.brandNavy,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  _sections[si].$2,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 16),
                ..._sections[si].$3.map(
                  (d) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Icon(
                            Icons.article_outlined,
                            color: AppColors.accentBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.$1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.brandNavy,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                d.$2,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => context.go(AppRoutes.support),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Ask support about this topic →'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        PageSection(
          child: Column(
            children: [
              Text(
                'Need hands-on implementation help?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Our team maps modules to your academic calendar, fee cycles, and staff roles.',
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
                    label: 'Open Help Center',
                    onPressed: () => context.go(AppRoutes.support),
                  ),
                  AsoltuButton(
                    label: 'Contact sales',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.contact),
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
