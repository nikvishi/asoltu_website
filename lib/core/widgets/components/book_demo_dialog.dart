import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../analytics/analytics_hooks.dart';
import '../../constants/app_urls.dart';
import '../../services/lead_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../utils/form_validators.dart';
import 'asoltu_button.dart';
import 'asoltu_text_field.dart';

/// Multi-step Book Live Demo dialog → `demo_requests`.
Future<void> showBookDemoDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => const BookDemoDialog(),
  );
}

class BookDemoDialog extends StatefulWidget {
  const BookDemoDialog({super.key});

  @override
  State<BookDemoDialog> createState() => _BookDemoDialogState();
}

class _BookDemoDialogState extends State<BookDemoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _school = TextEditingController();
  final _date = TextEditingController();
  final _time = TextEditingController();

  int _step = 0;
  bool _loading = false;
  bool _success = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _email.dispose();
    _school.dispose();
    _date.dispose();
    _time.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
    );
    if (picked != null) {
      _date.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 11, minute: 0),
    );
    if (picked != null && mounted) {
      _time.text = picked.format(context);
      setState(() {});
    }
  }

  bool _validateStep() {
    if (_step == 0) {
      return FormValidators.required(_name.text, 'Name') == null &&
          FormValidators.required(_school.text, 'School name') == null;
    }
    if (_step == 1) {
      return FormValidators.mobile(_mobile.text) == null &&
          FormValidators.email(_email.text) == null;
    }
    return FormValidators.required(_date.text, 'Date') == null &&
        FormValidators.required(_time.text, 'Time') == null;
  }

  Future<void> _next() async {
    setState(() => _error = null);
    if (!_validateStep()) {
      _formKey.currentState?.validate();
      setState(() => _error = 'Please complete the required fields.');
      return;
    }
    if (_step < 2) {
      setState(() => _step++);
      return;
    }
    setState(() => _loading = true);
    try {
      await leadService.submitDemoRequest(
        name: _name.text,
        mobile: _mobile.text,
        email: _email.text,
        preferredDate: _date.text,
        preferredTime: _time.text,
        schoolName: _school.text,
      );
      AnalyticsHooks.trackDemoBooked();
      if (mounted) setState(() => _success = true);
    } catch (_) {
      if (mounted) {
        setState(() =>
            _error =
                'Could not submit. Please try again or email ${AppUrls.infoEmailDisplay}.');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width < 400 ? 20 : 28),
          child: _success
              ? _Success(onClose: () => Navigator.pop(context))
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Book Live Demo',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: AppColors.brandNavy,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Close',
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _StepIndicator(step: _step),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: KeyedSubtree(
                          key: ValueKey(_step),
                          child: _step == 0
                              ? Column(
                                  children: [
                                    AsoltuTextField(
                                      label: 'Name *',
                                      controller: _name,
                                      validator: (v) =>
                                          FormValidators.required(v, 'Name'),
                                      prefixIcon:
                                          const Icon(Icons.person_outline),
                                    ),
                                    const SizedBox(height: 12),
                                    AsoltuTextField(
                                      label: 'School Name *',
                                      controller: _school,
                                      validator: (v) => FormValidators.required(
                                          v, 'School name'),
                                      prefixIcon:
                                          const Icon(Icons.apartment_outlined),
                                    ),
                                  ],
                                )
                              : _step == 1
                                  ? Column(
                                      children: [
                                        AsoltuTextField(
                                          label: 'Mobile *',
                                          controller: _mobile,
                                          keyboardType: TextInputType.phone,
                                          validator: FormValidators.mobile,
                                          prefixIcon:
                                              const Icon(Icons.phone_outlined),
                                        ),
                                        const SizedBox(height: 12),
                                        AsoltuTextField(
                                          label: 'Email *',
                                          controller: _email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: FormValidators.email,
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        GestureDetector(
                                          onTap: _pickDate,
                                          child: AbsorbPointer(
                                            child: AsoltuTextField(
                                              label: 'Preferred Date *',
                                              controller: _date,
                                              validator: (v) =>
                                                  FormValidators.required(
                                                      v, 'Date'),
                                              prefixIcon: const Icon(
                                                  Icons.calendar_today_outlined),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        GestureDetector(
                                          onTap: _pickTime,
                                          child: AbsorbPointer(
                                            child: AsoltuTextField(
                                              label: 'Preferred Time *',
                                              controller: _time,
                                              validator: (v) =>
                                                  FormValidators.required(
                                                      v, 'Time'),
                                              prefixIcon: const Icon(
                                                  Icons.schedule_outlined),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(_error!,
                            style: const TextStyle(color: AppColors.error)),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          if (_step > 0)
                            Expanded(
                              child: AsoltuButton(
                                label: 'Back',
                                variant: AsoltuButtonVariant.secondary,
                                onPressed: _loading
                                    ? null
                                    : () => setState(() => _step--),
                              ),
                            ),
                          if (_step > 0) const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: AsoltuButton(
                              label: _loading
                                  ? 'Submitting…'
                                  : _step == 2
                                      ? 'Confirm booking'
                                      : 'Continue',
                              onPressed: _loading ? null : _next,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    const labels = ['About you', 'Contact', 'Schedule'];
    return Row(
      children: [
        for (var i = 0; i < 3; i++) ...[
          Expanded(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 4,
                  decoration: BoxDecoration(
                    color: i <= step
                        ? AppColors.accentBlue
                        : AppColors.borderLight,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: i <= step
                        ? AppColors.brandNavy
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (i < 2) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle_rounded, size: 80, color: AppColors.success)
            .animate()
            .scale(begin: const Offset(0.5, 0.5), duration: 400.ms)
            .fadeIn(),
        const SizedBox(height: 16),
        Text(
          'You are on the list',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.brandNavy,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'We will confirm your demo slot by phone or email shortly.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        AsoltuButton(label: 'Done', expanded: true, onPressed: onClose),
      ],
    );
  }
}
