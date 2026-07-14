import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  static const faqs = [
    (
      'What is ASOLTU School ERP?',
      'ASOLTU is a cloud school management platform covering admissions, academics, fees, HR, communication, and analytics for modern institutions.',
    ),
    (
      'Is ASOLTU multi-campus?',
      'Yes. You can manage multiple campuses, branches, and education groups from a single secure control plane.',
    ),
    (
      'Does it include parent and teacher apps?',
      'ASOLTU provides dedicated portals for parents and teachers with attendance, fees, homework, results, and notifications.',
    ),
    (
      'Can we start with a free demo?',
      'Yes. Use Start Free Demo to explore the ERP, or Book Live Demo to schedule a guided walkthrough with our team.',
    ),
    (
      'Is our school data secure?',
      'ASOLTU is built with multi-tenant isolation, role-based access control, and enterprise-grade operational safeguards.',
    ),
    (
      'Does it support offline workflows?',
      'Critical operational flows are designed with offline support so campuses stay productive during connectivity issues.',
    ),
    (
      'Which modules are included?',
      'Admissions, attendance, fees, examinations, homework, library, transport, inventory, HR & payroll, analytics, AI reports, and communication.',
    ),
    (
      'Is ASOLTU AI-ready?',
      'Yes. AI-assisted reports and insights help leadership make faster decisions from live school data.',
    ),
    (
      'Can we migrate from our current system?',
      'Our team supports structured onboarding and data migration for schools moving from spreadsheets or legacy ERPs.',
    ),
    (
      'Where do we sign in?',
      'The ERP portal is hosted separately at erp.asoltu.com. Marketing and product information live on asoltu.com.',
    ),
    (
      'How do I book a live demo?',
      'Use the Book Demo button in the header or contact page. Submit preferred date and time — we confirm by phone or email.',
    ),
    (
      'What information do you store from contact forms?',
      'Name, school details, contact info, and your message are stored in secure Firebase collections used only for sales follow-up.',
    ),
    (
      'Do you support Indian boards and academic years?',
      'Yes. Academic structures, fee schedules, and sessions can be configured for common Indian school workflows.',
    ),
    (
      'Can finance and academics teams have different permissions?',
      'Yes. Role-based access lets you grant module-level permissions for admins, accountants, teachers, and staff.',
    ),
    (
      'Is training included?',
      'Onboarding packages typically include admin training. Enterprise plans can include dedicated success and training sessions.',
    ),
    (
      'How long does implementation take?',
      'Pilots can start quickly. Full campus rollouts depend on data migration and change management — usually weeks, not months.',
    ),
    (
      'Who do I contact for sales vs support?',
      'Sales: sales@asoltu.com · Support: support@asoltu.com · Careers: careers@asoltu.com',
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
              eyebrow: 'FAQ',
              title: 'Answers for school leaders',
              subtitle:
                  'Product, security, demos, onboarding, and data handling — clear answers up front.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              children: [
                for (final faq in faqs)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _FaqTile(question: faq.$1, answer: faq.$2),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          iconColor: AppColors.accentBlue,
          collapsedIconColor: AppColors.brandNavy,
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            question,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w600,
                ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.55,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
