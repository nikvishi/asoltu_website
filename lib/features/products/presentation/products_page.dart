import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/widgets.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const _products = <_Product>[
    _Product(
      Icons.school_outlined,
      'School ERP',
      'Complete operating system for K–12 campuses — admissions through analytics.',
      'One secure system of record for academics, finance, and parent trust.',
      [
        'Admissions & enrollment pipeline',
        'Attendance, fees, exams, homework',
        'Role-based admin, teacher, parent access',
        'Campus dashboards and AI summaries',
      ],
      [
        'Replace spreadsheet chaos',
        'Faster fee collection cycles',
        'Clear parent communication',
      ],
    ),
    _Product(
      Icons.menu_book_outlined,
      'Coaching ERP',
      'High-volume batch institutes with rapid enquiry-to-fee conversion.',
      'Built for coaching tempo: batches, collections, and staff coordination.',
      [
        'Batch & enquiry management',
        'Fee cycles at coaching pace',
        'Staff coordination tools',
        'Parent / guardian updates',
      ],
      [
        'Higher conversion from enquiry',
        'Cleaner collection tracking',
        'Less operational firefighting',
      ],
    ),
    _Product(
      Icons.account_balance_outlined,
      'College ERP',
      'Department-aware administration for higher secondary and college campuses.',
      'Structure departments, assessments, and multi-role operations cleanly.',
      [
        'Department structures',
        'Exams & results workflows',
        'Multi-role RBAC',
        'Student lifecycle records',
      ],
      [
        'Clear departmental ownership',
        'Reliable assessment cycles',
        'Audit-friendly administration',
      ],
    ),
    _Product(
      Icons.apartment_outlined,
      'Multi Campus ERP',
      'Education groups and multi-brand networks with shared visibility.',
      'Central insight with local campus autonomy and tenant isolation.',
      [
        'Multi-tenant campus model',
        'Cross-campus KPIs',
        'Group-level reporting',
        'Consistent policy templates',
      ],
      [
        'Group leadership visibility',
        'Standardized rollouts',
        'Isolated campus data',
      ],
    ),
    _Product(
      Icons.person_outline,
      'Teacher App',
      'Classroom tools teachers actually open every day.',
      'Attendance, homework, results, and class communication in one portal.',
      [
        'Fast attendance marking',
        'Homework & submissions',
        'Results entry support',
        'Class announcements',
      ],
      [
        'Hours saved weekly',
        'Fewer missed updates',
        'Consistent classroom records',
      ],
    ),
    _Product(
      Icons.family_restroom_outlined,
      'Parent App',
      'Transparent status for fees, attendance, homework, and notices.',
      'Build family trust with timely, accurate campus information.',
      [
        'Fee status & receipts visibility',
        'Attendance history',
        'Homework & notices',
        'Multi-child friendly views',
      ],
      [
        'Fewer front-office calls',
        'Higher parent confidence',
        'Clear payment awareness',
      ],
    ),
    _Product(
      Icons.backpack_outlined,
      'Student App',
      'Learner-facing access to timetable, results, homework, and library.',
      'Keep students informed without admin bottlenecks.',
      [
        'Timetable access',
        'Results & report cards',
        'Homework tracking',
        'Library status',
      ],
      [
        'Self-serve information',
        'Better study planning',
        'Reduced admin load',
      ],
    ),
    _Product(
      Icons.badge_outlined,
      'HR',
      'Staff records, leave, and people operations for education employers.',
      'Keep employee data accurate and leave workflows transparent.',
      [
        'Staff profiles',
        'Leave requests & balances',
        'Role alignment',
        'People operations basics',
      ],
      [
        'Cleaner staff records',
        'Faster leave decisions',
        'Less HR paperwork',
      ],
    ),
    _Product(
      Icons.account_balance_wallet_outlined,
      'Finance',
      'Fee structures, invoices, receipts, dues, and collection health.',
      'Finance teams run term cycles with clarity and control.',
      [
        'Fee structures & invoices',
        'Receipts & reminders',
        'Dues tracking',
        'Collection health views',
      ],
      [
        'Improved collection discipline',
        'Fewer billing disputes',
        'Leadership-ready finance views',
      ],
    ),
    _Product(
      Icons.fact_check_outlined,
      'Attendance',
      'Live student and staff attendance with history and alerts.',
      'Daily discipline that parents and principals can trust.',
      [
        'Quick daily marking',
        'Historical reports',
        'Parent alerts',
        'Staff attendance options',
      ],
      [
        'Higher marking consistency',
        'Early absence visibility',
        'Audit-ready history',
      ],
    ),
    _Product(
      Icons.assignment_outlined,
      'Examination',
      'Assessments, marks entry, results, and report-card ready outputs.',
      'Run exam cycles without spreadsheet risk.',
      [
        'Assessment setup',
        'Marks workflows',
        'Results publication',
        'Report card outputs',
      ],
      [
        'Faster result cycles',
        'Fewer entry errors',
        'Clear parent communication',
      ],
    ),
    _Product(
      Icons.home_work_outlined,
      'Homework',
      'Assignments, submissions, and classroom follow-ups.',
      'Keep learning work visible for teachers, students, and parents.',
      [
        'Assignment creation',
        'Submission tracking',
        'Class follow-ups',
        'Parent visibility',
      ],
      [
        'Better completion rates',
        'Shared accountability',
        'Less WhatsApp chaos',
      ],
    ),
    _Product(
      Icons.directions_bus_outlined,
      'Transport',
      'Routes, vehicles, and passenger operations tied to student records.',
      'Coordinate transport without separate disconnected tools.',
      [
        'Route management',
        'Vehicle records',
        'Passenger linking',
        'Operational tracking',
      ],
      [
        'Clearer route ownership',
        'Safer passenger mapping',
        'Integrated student records',
      ],
    ),
    _Product(
      Icons.hotel_outlined,
      'Hostel',
      'Room allocation, occupancy, and residential campus workflows.',
      'Boarding operations stay organized and accountable.',
      [
        'Room allocation',
        'Occupancy tracking',
        'Residential workflows',
        'Student linkage',
      ],
      [
        'Transparent occupancy',
        'Faster allocation',
        'Cleaner residential records',
      ],
    ),
    _Product(
      Icons.local_library_outlined,
      'Library',
      'Catalog, issue/return, and overdue tracking for campus libraries.',
      'Modern library operations connected to student identity.',
      [
        'Catalog management',
        'Issue & return',
        'Overdue tracking',
        'Student linkage',
      ],
      [
        'Lower loss rates',
        'Faster issue desks',
        'Clear overdue visibility',
      ],
    ),
    _Product(
      Icons.auto_awesome,
      'AI Assistant',
      'Decision-ready insights and summaries from live operational data.',
      'Help leaders act — not drown in charts.',
      [
        'Operational summaries',
        'Leadership-friendly insights',
        'Campus KPI narratives',
        'Education-context reporting',
      ],
      [
        'Faster leadership decisions',
        'Less manual report writing',
        'Focus on real priorities',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 16),
          child: FadeIn(
            child: Column(
              children: [
                const PageBreadcrumb(current: 'Products'),
                const SizedBox(height: 20),
                const SectionHeading(
                  eyebrow: 'Products',
                  title: 'The ASOLTU product suite',
                  subtitle:
                      'Modular products for schools, coaching institutes, colleges, and multi-campus groups — connected, role-aware, and production-ready.',
                  center: true,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AsoltuButton(
                      label: 'Start Free Demo',
                      onPressed: () => launchUrl(
                        Uri.parse(AppUrls.erpPortal),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    AsoltuButton(
                      label: 'Book Live Demo',
                      variant: AsoltuButtonVariant.secondary,
                      onPressed: () => showBookDemoDialog(context),
                    ),
                    AsoltuButton(
                      label: 'View Pricing',
                      variant: AsoltuButtonVariant.secondary,
                      onPressed: () => context.go(AppRoutes.pricing),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 960;
              if (!wide) {
                return Column(
                  children: [
                    for (final p in _products) ...[
                      _ProductCard(product: p),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              }
              final rows = <Widget>[];
              for (var i = 0; i < _products.length; i += 2) {
                rows.add(
                  Padding(
                    padding: EdgeInsets.only(bottom: i + 2 < _products.length ? 16 : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _ProductCard(product: _products[i])),
                        const SizedBox(width: 16),
                        Expanded(
                          child: i + 1 < _products.length
                              ? _ProductCard(product: _products[i + 1])
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(children: rows);
            },
          ),
        ),
        PageSection(
          child: Column(
            children: [
              Text(
                'Need a tailored module mix?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'We map products to your academic calendar, fee cycles, and campus roles.',
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
                    label: 'Contact Sales',
                    onPressed: () => context.go(AppRoutes.contact),
                  ),
                  AsoltuButton(
                    label: 'Explore Solutions',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.solutions),
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

class _Product {
  const _Product(
    this.icon,
    this.title,
    this.description,
    this.benefitLead,
    this.features,
    this.benefits,
  );

  final IconData icon;
  final String title;
  final String description;
  final String benefitLead;
  final List<String> features;
  final List<String> benefits;
}

class _ProductCard extends StatefulWidget {
  const _ProductCard({required this.product});
  final _Product product;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Semantics(
      label: p.title,
      child: MouseRegion(
        onEnter: (_) => setState(() => _h = true),
        onExit: (_) => setState(() => _h = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _h ? -3 : 0, 0),
          padding: const EdgeInsets.all(22),
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(p.icon, color: AppColors.accentBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      p.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.brandNavy,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(p.description, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                p.benefitLead,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentBlue,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Features',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.brandNavy,
                    ),
              ),
              const SizedBox(height: 6),
              for (final f in p.features)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 15, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(f, style: const TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                'Benefits',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.brandNavy,
                    ),
              ),
              const SizedBox(height: 6),
              for (final b in p.benefits)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_outward_rounded,
                          size: 14, color: AppColors.accentGoldDark),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(b, style: const TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AsoltuButton(
                    label: 'Book demo',
                    onPressed: () => showBookDemoDialog(context),
                  ),
                  AsoltuButton(
                    label: 'Talk to sales',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => context.go(AppRoutes.contact),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
