import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/analytics/analytics_hooks.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/services/lead_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/form_validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../home/presentation/widgets/faq_section.dart';

/// Production contact page with lead form, business info, map, and CTAs.
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _schoolName = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _students = TextEditingController();
  final _message = TextEditingController();

  String _schoolType = 'K-12 School';
  bool _loading = false;
  bool _success = false;
  String? _error;

  static const _schoolTypes = [
    'K-12 School',
    'Coaching Institute',
    'College',
    'University',
    'Education Group',
    'Other',
  ];

  @override
  void dispose() {
    _fullName.dispose();
    _schoolName.dispose();
    _mobile.dispose();
    _email.dispose();
    _city.dispose();
    _state.dispose();
    _students.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    try {
      await leadService.submitContact(
        fullName: _fullName.text,
        schoolName: _schoolName.text,
        mobile: _mobile.text,
        email: _email.text,
        city: _city.text,
        state: _state.text,
        schoolType: _schoolType,
        numberOfStudents: _students.text,
        message: _message.text,
      );
      AnalyticsHooks.trackLeadSubmitted('contact');
      if (mounted) setState(() => _success = true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _error =
              'Unable to send right now. Please email sales@asoltu.com or try again.';
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 16),
          child: const FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: 'Contact'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'Contact',
                  title: 'Talk to the ASOLTU team',
                  subtitle:
                      'ASOLTU Tech Solutions helps schools, coaching institutes, colleges, and education groups modernize operations with a secure multi-tenant ERP. Request a demo, ask about pricing, or get onboarding guidance.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        PageSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 960;
              final form = _success
                  ? const _ContactSuccess()
                  : _ContactForm(
                      formKey: _formKey,
                      fullName: _fullName,
                      schoolName: _schoolName,
                      mobile: _mobile,
                      email: _email,
                      city: _city,
                      state: _state,
                      students: _students,
                      message: _message,
                      schoolType: _schoolType,
                      schoolTypes: _schoolTypes,
                      loading: _loading,
                      error: _error,
                      onSchoolType: (v) => setState(() => _schoolType = v),
                      onSubmit: _submit,
                      onBookDemo: () => showBookDemoDialog(context),
                    );
              final side = const _ContactAside();

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: form),
                    const SizedBox(width: 28),
                    Expanded(flex: 4, child: side),
                  ],
                );
              }
              return Column(
                children: [
                  form,
                  const SizedBox(height: 28),
                  side,
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
                eyebrow: 'Channels',
                title: 'Sales, support, and WhatsApp',
                center: true,
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 900 ? 3 : 1;
                  final items = [
                    (
                      Icons.storefront_outlined,
                      'Sales',
                      AppUrls.salesEmailDisplay,
                      AppUrls.salesEmail,
                      'Commercial questions & demos',
                    ),
                    (
                      Icons.support_agent_outlined,
                      'Support',
                      AppUrls.supportEmailDisplay,
                      AppUrls.supportEmail,
                      'Product help for live campuses',
                    ),
                    (
                      Icons.chat_rounded,
                      'WhatsApp',
                      AppUrls.phoneDisplay,
                      AppUrls.whatsApp,
                      'Quick questions during business hours',
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
                      childAspectRatio: cols == 1 ? 2.6 : 1.4,
                    ),
                    itemBuilder: (context, i) {
                      final item = items[i];
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
                            Icon(item.$1, color: AppColors.accentBlue),
                            const SizedBox(height: 10),
                            Text(
                              item.$2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.brandNavy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.$3,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.accentBlue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(child: Text(item.$5)),
                            TextButton(
                              onPressed: () => launchUrl(
                                Uri.parse(item.$4),
                                mode: LaunchMode.externalApplication,
                              ),
                              child: const Text('Open →'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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
                    label: 'WhatsApp',
                    variant: AsoltuButtonVariant.secondary,
                    icon: Icons.chat_rounded,
                    onPressed: () => launchUrl(
                      Uri.parse(AppUrls.whatsApp),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  AsoltuButton(
                    label: 'Call ${AppUrls.phoneDisplay}',
                    variant: AsoltuButtonVariant.secondary,
                    onPressed: () => launchUrl(Uri.parse(AppUrls.phoneTel)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const FaqSection(),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.fullName,
    required this.schoolName,
    required this.mobile,
    required this.email,
    required this.city,
    required this.state,
    required this.students,
    required this.message,
    required this.schoolType,
    required this.schoolTypes,
    required this.loading,
    required this.error,
    required this.onSchoolType,
    required this.onSubmit,
    required this.onBookDemo,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullName;
  final TextEditingController schoolName;
  final TextEditingController mobile;
  final TextEditingController email;
  final TextEditingController city;
  final TextEditingController state;
  final TextEditingController students;
  final TextEditingController message;
  final String schoolType;
  final List<String> schoolTypes;
  final bool loading;
  final String? error;
  final ValueChanged<String> onSchoolType;
  final VoidCallback onSubmit;
  final VoidCallback onBookDemo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send a message',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Response SLA: we aim to reply within 1 business day.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 16),
            AsoltuTextField(
              label: 'Full Name *',
              controller: fullName,
              validator: (v) => FormValidators.required(v, 'Full name'),
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 12),
            AsoltuTextField(
              label: 'School Name *',
              controller: schoolName,
              validator: (v) => FormValidators.required(v, 'School name'),
              prefixIcon: const Icon(Icons.apartment_outlined),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, c) {
                final row = c.maxWidth > 520;
                final mobileField = AsoltuTextField(
                  label: 'Mobile Number *',
                  controller: mobile,
                  keyboardType: TextInputType.phone,
                  validator: FormValidators.mobile,
                  prefixIcon: const Icon(Icons.phone_outlined),
                );
                final emailField = AsoltuTextField(
                  label: 'Email *',
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                );
                if (row) {
                  return Row(
                    children: [
                      Expanded(child: mobileField),
                      const SizedBox(width: 12),
                      Expanded(child: emailField),
                    ],
                  );
                }
                return Column(
                  children: [
                    mobileField,
                    const SizedBox(height: 12),
                    emailField,
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, c) {
                final cityField = AsoltuTextField(
                  label: 'City *',
                  controller: city,
                  validator: (v) => FormValidators.required(v, 'City'),
                  prefixIcon: const Icon(Icons.location_city_outlined),
                );
                final stateField = AsoltuTextField(
                  label: 'State *',
                  controller: state,
                  validator: (v) => FormValidators.required(v, 'State'),
                  prefixIcon: const Icon(Icons.map_outlined),
                );
                if (c.maxWidth > 520) {
                  return Row(
                    children: [
                      Expanded(child: cityField),
                      const SizedBox(width: 12),
                      Expanded(child: stateField),
                    ],
                  );
                }
                return Column(
                  children: [
                    cityField,
                    const SizedBox(height: 12),
                    stateField,
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: schoolType,
              decoration: const InputDecoration(
                labelText: 'School Type *',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: [
                for (final t in schoolTypes)
                  DropdownMenuItem(value: t, child: Text(t)),
              ],
              onChanged: (v) {
                if (v != null) onSchoolType(v);
              },
            ),
            const SizedBox(height: 12),
            AsoltuTextField(
              label: 'Number of Students *',
              controller: students,
              keyboardType: TextInputType.number,
              validator: (v) => FormValidators.required(v, 'Number of students'),
              prefixIcon: const Icon(Icons.groups_outlined),
            ),
            const SizedBox(height: 12),
            AsoltuTextField(
              label: 'Message *',
              controller: message,
              maxLines: 4,
              validator: (v) => FormValidators.required(v, 'Message'),
              prefixIcon: const Icon(Icons.chat_bubble_outline),
            ),
            if (error != null) ...[
              const SizedBox(height: 12),
              Text(error!, style: const TextStyle(color: AppColors.error)),
            ],
            const SizedBox(height: 20),
            AsoltuButton(
              label: loading ? 'Sending…' : 'Submit Enquiry',
              expanded: true,
              onPressed: loading ? null : onSubmit,
            ),
            const SizedBox(height: 10),
            AsoltuButton(
              label: 'Book Live Demo',
              variant: AsoltuButtonVariant.secondary,
              expanded: true,
              onPressed: onBookDemo,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactSuccess extends StatelessWidget {
  const _ContactSuccess();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, size: 80, color: AppColors.success)
              .animate()
              .scale(begin: const Offset(0.5, 0.5), duration: 450.ms)
              .fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Thank you — we received your message',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Our team will get back to you within one business day.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ContactAside extends StatelessWidget {
  const _ContactAside();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Business information',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 14),
              _line(Icons.business_outlined, 'ASOLTU Tech Solutions', null),
              _line(Icons.email_outlined, AppUrls.salesEmailDisplay, AppUrls.salesEmail),
              _line(Icons.support_agent_outlined, AppUrls.supportEmailDisplay, AppUrls.supportEmail),
              _line(Icons.phone_outlined, AppUrls.phoneDisplay, AppUrls.phoneTel),
              _line(Icons.schedule_outlined, AppUrls.businessHours, null),
              _line(Icons.location_on_outlined, AppUrls.officeAddress, null),
              _line(Icons.language, 'erp.asoltu.com', AppUrls.erpPortal),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.brandNavy.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderLight),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: _MapGridPainter()),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: AppShadows.soft,
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: AppColors.accentBlue),
                      SizedBox(height: 6),
                      Text(
                        'ASOLTU Office',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandNavy,
                        ),
                      ),
                      Text(
                        AppUrls.officeAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () => launchUrl(
            Uri.parse(AppUrls.googleMapsSearch),
            mode: LaunchMode.externalApplication,
          ),
          icon: const Icon(Icons.open_in_new, size: 16),
          label: const Text('Open in Google Maps'),
        ),
      ],
    );
  }

  Widget _line(IconData icon, String label, String? url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: url == null
            ? null
            : () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: AppColors.accentBlue),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.brandNavy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFE8EEF8);
    canvas.drawRect(Offset.zero & size, bg);
    final line = Paint()
      ..color = const Color(0xFFC5D0E6)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (var y = 0.0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    final road = Paint()
      ..color = const Color(0xFFB8C4DC)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.4),
      road,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.55, size.height),
      road,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
