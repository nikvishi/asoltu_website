import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import 'floating_soft_motion.dart';

/// Product showcase — Desktop / Tablet / Mobile with floating cards.
class ScreenshotsSection extends StatefulWidget {
  const ScreenshotsSection({super.key});

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  int _index = 0;

  static const _devices = [
    (Icons.desktop_windows_outlined, 'Desktop', 'Admin control plane'),
    (Icons.tablet_mac_outlined, 'Tablet', 'Campus operations'),
    (Icons.phone_iphone_outlined, 'Mobile', 'Parent & teacher apps'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Product showcase',
              title: 'Designed for every screen',
              subtitle:
                  'A polished experience across desktop, tablet, and mobile — without sacrificing power.',
              center: true,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(_devices.length, (i) {
              final active = i == _index;
              return ChoiceChip(
                label: Text(_devices[i].$2),
                selected: active,
                onSelected: (_) => setState(() => _index = i),
                selectedColor: AppColors.accentBlue.withValues(alpha: 0.12),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active ? AppColors.accentBlue : AppColors.brandNavy,
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
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _DeviceShowcase(
              key: ValueKey(_index),
              icon: _devices[_index].$1,
              title: _devices[_index].$2,
              subtitle: _devices[_index].$3,
              compact: _index == 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceShowcase extends StatelessWidget {
  const _DeviceShowcase({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: compact ? 220 : double.infinity,
            constraints: BoxConstraints(maxWidth: compact ? 260 : 820),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: AppShadows.elevated,
            ),
            child: Column(
              children: [
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, size: 18, color: AppColors.accentBlue),
                      const SizedBox(width: 8),
                      Text(
                        '$title · $subtitle',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.brandNavy,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.brandNavy.withValues(alpha: 0.95),
                          AppColors.accentBlue.withValues(alpha: 0.78),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(
                            3,
                            (i) => Expanded(
                              child: Container(
                                height: 54,
                                margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            top: 70,
            child: FloatingSoftMotion(
              amplitude: 6,
              child: _MiniBadge(
                icon: Icons.notifications_active_outlined,
                label: 'Alerts live',
              ),
            ).animate().fadeIn(delay: 120.ms),
          ),
          Positioned(
            right: 12,
            bottom: 60,
            child: FloatingSoftMotion(
              amplitude: 8,
              duration: const Duration(milliseconds: 3000),
              child: _MiniBadge(
                icon: Icons.verified_user_outlined,
                label: 'Secure RBAC',
              ),
            ).animate().fadeIn(delay: 180.ms),
          ),
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.accentBlue),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}
