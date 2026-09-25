import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Product showcase — clean UI mockups until real screenshots replace them.
class ScreenshotsSection extends StatefulWidget {
  const ScreenshotsSection({super.key});

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  int _index = 0;

  static const _views = [
    (Icons.desktop_windows_outlined, 'Desktop Dashboard', 'Admin control plane'),
    (Icons.person_outline, 'Teacher App', 'Classroom operations'),
    (Icons.family_restroom, 'Parent App', 'Family transparency'),
    (Icons.backpack_outlined, 'Student App', 'Learner self-serve'),
    (Icons.assessment_outlined, 'Reports', 'Operational reporting'),
    (Icons.insights_outlined, 'Analytics', 'Leadership insights'),
    (Icons.dark_mode_outlined, 'Dark Mode', 'Focus-friendly UI'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Product showcase',
              title: 'Designed for every role and screen',
              subtitle:
                  'Clean UI mockups of the ASOLTU experience — real product screenshots will replace these as available.',
              center: true,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(_views.length, (i) {
              final active = i == _index;
              return ChoiceChip(
                label: Text(_views[i].$2),
                selected: active,
                onSelected: (_) => setState(() => _index = i),
                selectedColor: AppColors.accentBlue.withValues(alpha: 0.12),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active ? AppColors.accentBlue : AppColors.brandNavy,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: active
                      ? AppColors.accentBlue.withValues(alpha: 0.4)
                      : AppColors.borderLight,
                ),
                backgroundColor: Colors.white,
              );
            }),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            child: _MockFrame(
              key: ValueKey(_index),
              icon: _views[_index].$1,
              title: _views[_index].$2,
              subtitle: _views[_index].$3,
              dark: _index == 6,
              compact: _index == 1 || _index == 2 || _index == 3,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockFrame extends StatelessWidget {
  const _MockFrame({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.dark = false,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dark;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.backgroundDark : Colors.white;
    final fg = dark ? Colors.white : AppColors.brandNavy;
    final muted = dark ? Colors.white70 : AppColors.textSecondary;
    final panel = dark ? AppColors.surfaceDark : AppColors.surfaceMuted;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: compact ? 380 : 880),
        child: Container(
          height: compact ? 520 : 420,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: dark ? AppColors.borderDark : AppColors.borderLight,
            ),
            boxShadow: AppShadows.elevated,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: dark
                      ? Colors.white.withValues(alpha: 0.04)
                      : AppColors.surfaceSoft,
                  border: Border(
                    bottom: BorderSide(
                      color: dark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, size: 18, color: AppColors.accentBlue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: fg,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(color: muted, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    if (dark)
                      const Icon(Icons.dark_mode, size: 16, color: AppColors.accentGold),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (!compact)
                        Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 14),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: panel,
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final item in [
                                'Dashboard',
                                'Students',
                                'Fees',
                                'Attendance',
                                'Reports',
                              ])
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: muted,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: panel,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.lg),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: fg,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Illustrative mockup of the $title experience. Real screenshots will appear here when available.',
                                      style: TextStyle(
                                        color: muted,
                                        height: 1.45,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    for (var i = 0; i < 3; i++)
                                      FractionallySizedBox(
                                        widthFactor: (1 - i * 0.15).clamp(0.55, 1.0),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 10,
                                          margin: const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.accentBlue
                                                .withValues(alpha: 0.12 + i * 0.05),
                                            borderRadius: BorderRadius.circular(99),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: _tile(panel, fg, 'Metric A')),
                                const SizedBox(width: 10),
                                Expanded(child: _tile(panel, fg, 'Metric B')),
                                const SizedBox(width: 10),
                                Expanded(child: _tile(panel, fg, 'Metric C')),
                              ],
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
      ),
    );
  }

  Widget _tile(Color panel, Color fg, String label) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          label,
          style: TextStyle(
            color: fg.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
