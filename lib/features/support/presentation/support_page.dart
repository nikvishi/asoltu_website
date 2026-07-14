import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/form_validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../home/presentation/widgets/faq_section.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _school = TextEditingController();
  final _subject = TextEditingController();
  final _details = TextEditingController();
  String _priority = 'Normal';
  bool _loading = false;
  bool _sent = false;

  static const _levels = [
    (
      'Starter',
      'Email support',
      'Best-effort responses on business days for evaluation and core questions.',
      ['Email channel', 'Documentation access', 'Community-style self-serve'],
    ),
    (
      'Professional',
      'Priority support',
      'Faster turnaround for live campuses on paid Professional plans.',
      ['Priority inbox', 'Onboarding guidance', 'Module how-to assistance'],
    ),
    (
      'Enterprise',
      'Dedicated success',
      'Named success contact options and custom SLAs via enterprise agreement.',
      ['Dedicated channel', 'Custom SLA options', 'Escalation paths'],
    ),
  ];

  static const _kb = [
    ('Getting started', 'Academic year, roles, and first-week checklist.', AppRoutes.documentation),
    ('Fees & receipts', 'Structures, invoices, and collection workflows.', AppRoutes.documentation),
    ('Attendance basics', 'Marking, reports, and parent alerts.', AppRoutes.documentation),
    ('Roles & permissions', 'RBAC patterns for staff and parents.', AppRoutes.documentation),
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _school.dispose();
    _subject.dispose();
    _details.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@asoltu.com',
      queryParameters: {
        'subject': '[$_priority] ${_subject.text}',
        'body':
            'Name: ${_name.text}\nSchool: ${_school.text}\nEmail: ${_email.text}\nPriority: $_priority\n\n${_details.text}',
      },
    );
    await launchUrl(uri);
    if (mounted) {
      setState(() {
        _loading = false;
        _sent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 24),
          child: const FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: 'Support'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'Support',
                  title: 'Help Center for live campuses',
                  subtitle:
                      'Documentation, training, onboarding, ticket paths, and SLAs for ASOLTU School ERP.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        PageSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 900 ? 3 : 1;
              final cards = [
                _ActionCard(
                  icon: Icons.menu_book_outlined,
                  title: 'Documentation',
                  body: 'Implementation and product references.',
                  action: 'Open docs',
                  onTap: () => context.go(AppRoutes.documentation),
                ),
                _ActionCard(
                  icon: Icons.email_outlined,
                  title: 'Email support',
                  body: 'support@asoltu.com',
                  action: 'Email us',
                  onTap: () => launchUrl(Uri.parse(AppUrls.supportEmail)),
                ),
                _ActionCard(
                  icon: Icons.calendar_month_outlined,
                  title: 'Talk to sales',
                  body: 'Demos, pricing, and commercial questions.',
                  action: 'Contact',
                  onTap: () => context.go(AppRoutes.contact),
                ),
              ];
              if (cols == 1) {
                return Column(
                  children: [
                    for (final card in cards) ...[
                      card,
                      const SizedBox(height: 12),
                    ],
                  ],
                );
              }
              return Row(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    Expanded(child: cards[i]),
                    if (i < cards.length - 1) const SizedBox(width: 12),
                  ],
                ],
              );
            },
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Response time',
                title: 'Clear expectations',
                center: true,
              ),
              const SizedBox(height: 16),
              Text(
                'We aim to reply to support emails within 1 business day. Priority and Enterprise plans receive faster handling per agreement. Critical production issues are escalated immediately during business hours (Mon–Fri, 10:00–18:00 IST).',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Support levels',
                title: 'Plans aligned to campus needs',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900 ? 3 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _levels.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: cols == 1 ? 1.5 : 1.05,
                    ),
                    itemBuilder: (context, i) {
                      final l = _levels[i];
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
                            Text(
                              l.$1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentBlue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              l.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandNavy,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(l.$3),
                            const SizedBox(height: 12),
                            for (final f in l.$4)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded,
                                        size: 16, color: AppColors.success),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(f)),
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
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'How tickets work',
                title: 'Ticket system explained',
                center: true,
              ),
              const SizedBox(height: 16),
              for (final step in [
                ('1 · Submit', 'Use the ticket form or email support@asoltu.com with school name, priority, and details.'),
                ('2 · Triage', 'We classify by priority and route to product specialists during business hours.'),
                ('3 · Resolve', 'We respond with guidance, documentation links, or escalation for production issues.'),
                ('4 · Follow-up', 'Professional and Enterprise plans receive tighter follow-up and success paths.'),
              ])
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.accentBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(step.$2)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Training & onboarding',
                title: 'Help your team go live with confidence',
                center: true,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900 ? 3 : 1;
                  final items = [
                    (
                      Icons.school_outlined,
                      'Onboarding',
                      'Structured first-week setup: academic year, roles, fees, attendance, and champions.',
                    ),
                    (
                      Icons.groups_outlined,
                      'Training',
                      'Role-based sessions for admins, teachers, and finance teams as part of paid plans.',
                    ),
                    (
                      Icons.menu_book_outlined,
                      'Documentation',
                      'Self-serve guides for modules, RBAC, and operational playbooks.',
                    ),
                  ];
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: cols == 1 ? 2.4 : 1.2,
                    ),
                    itemBuilder: (context, i) {
                      final t = items[i];
                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(t.$1, color: AppColors.accentBlue),
                            const SizedBox(height: 10),
                            Text(
                              t.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandNavy,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(child: Text(t.$3)),
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
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Knowledge base',
                title: 'Self-serve answers',
                center: true,
              ),
              const SizedBox(height: 20),
              ..._kb.map(
                (k) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      onTap: () => context.go(k.$3),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.article_outlined,
                                color: AppColors.accentBlue),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    k.$1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.brandNavy,
                                    ),
                                  ),
                                  Text(k.$2),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        PageSection(
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Submit a ticket',
                title: 'Tell us what you need',
                subtitle:
                    'We open your email client with a structured ticket so our team can respond quickly.',
                center: true,
              ),
              const SizedBox(height: 24),
              if (_sent)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: AppColors.success, size: 48),
                      SizedBox(height: 12),
                      Text(
                        'Ticket draft opened',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.brandNavy,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Send the email from your client to complete submission. We aim to respond within 1 business day.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 720),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AsoltuTextField(
                          label: 'Name *',
                          controller: _name,
                          validator: (v) => FormValidators.required(v, 'Name'),
                        ),
                        const SizedBox(height: 12),
                        AsoltuTextField(
                          label: 'Work email *',
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormValidators.email,
                        ),
                        const SizedBox(height: 12),
                        AsoltuTextField(
                          label: 'School / Institution *',
                          controller: _school,
                          validator: (v) =>
                              FormValidators.required(v, 'School name'),
                        ),
                        const SizedBox(height: 12),
                        AsoltuTextField(
                          label: 'Subject *',
                          controller: _subject,
                          validator: (v) => FormValidators.required(v, 'Subject'),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          // ignore: deprecated_member_use
                          value: _priority,
                          decoration: const InputDecoration(
                            labelText: 'Priority',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Low', child: Text('Low')),
                            DropdownMenuItem(
                                value: 'Normal', child: Text('Normal')),
                            DropdownMenuItem(
                                value: 'High', child: Text('High')),
                            DropdownMenuItem(
                                value: 'Critical', child: Text('Critical')),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _priority = v);
                          },
                        ),
                        const SizedBox(height: 12),
                        AsoltuTextField(
                          label: 'Details *',
                          controller: _details,
                          maxLines: 5,
                          validator: (v) => FormValidators.required(v, 'Details'),
                        ),
                        const SizedBox(height: 18),
                        AsoltuButton(
                          label: _loading ? 'Opening…' : 'Submit ticket',
                          expanded: true,
                          onPressed: _loading ? null : _submit,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const FaqSection(),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.action,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.accentBlue, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, textAlign: TextAlign.center),
          const SizedBox(height: 14),
          AsoltuButton(label: action, onPressed: onTap),
        ],
      ),
    );
  }
}
