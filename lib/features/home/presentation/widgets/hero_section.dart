import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import 'floating_soft_motion.dart';

/// Premium hero — brand message for schools & businesses.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.backgroundLight,
      padding: const EdgeInsets.only(top: 48, bottom: AppSpacing.section),
      child: ResponsiveBuilder(
        builder: (context, bp, _) {
          final w = MediaQuery.sizeOf(context).width;
          final desktop = w >= 960;

          if (desktop) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _HeroCopy()),
                SizedBox(width: 48),
                Expanded(flex: 5, child: _HeroVisual()),
              ],
            );
          }
          return const Column(
            children: [
              _HeroCopy(),
              SizedBox(height: 40),
              _HeroVisual(),
            ],
          );
        },
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final size = w < Breakpoints.mobile
        ? 32.0
        : w < Breakpoints.tablet
            ? 40.0
            : 52.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.accentBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: AppColors.accentBlue.withValues(alpha: 0.16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 14, color: AppColors.accentBlue),
              const SizedBox(width: 8),
              Text(
                'ASOLTU TECHNOLOGIES',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.accentBlue,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.2, end: 0, duration: 400.ms),
        const SizedBox(height: 22),
        Semantics(
          header: true,
          label:
              'Building Intelligent Software for Schools and Businesses — ASOLTU Technologies',
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Building Intelligent Software\n',
                  style: TextStyle(
                    fontSize: size,
                    fontWeight: FontWeight.w700,
                    height: 1.12,
                    letterSpacing: -1.0,
                    color: AppColors.brandNavy,
                  ),
                ),
                TextSpan(
                  text: 'for Schools & Businesses',
                  style: TextStyle(
                    fontSize: size,
                    fontWeight: FontWeight.w700,
                    height: 1.12,
                    letterSpacing: -1.0,
                    color: AppColors.accentBlue,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 480.ms)
            .slideY(begin: 0.08, end: 0, duration: 480.ms),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            AppStrings.brandSubheadline,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 17,
                  height: 1.65,
                  color: AppColors.textSecondary,
                ),
          ),
        ).animate().fadeIn(delay: 140.ms, duration: 450.ms),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AsoltuButton(
              label: 'Book Demo',
              icon: Icons.calendar_month_outlined,
              onPressed: () => showBookDemoDialog(context),
            ),
            AsoltuButton(
              label: 'Explore Solutions',
              variant: AsoltuButtonVariant.secondary,
              icon: Icons.grid_view_rounded,
              onPressed: () => context.go(AppRoutes.products),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms)
            .slideY(begin: 0.1, end: 0, duration: 400.ms),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _TrustLabel(Icons.flag_outlined, 'Made in India 🇮🇳'),
            _TrustLabel(Icons.cloud_done_outlined, 'Secure Cloud Platform'),
            _TrustLabel(Icons.flutter_dash, 'Flutter Powered'),
            _TrustLabel(Icons.devices_outlined, 'Responsive Design'),
          ],
        ).animate().fadeIn(delay: 280.ms, duration: 400.ms),
      ],
    );
  }
}

class _TrustLabel extends StatelessWidget {
  const _TrustLabel(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.accentBlue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              child: const _DashboardMock(),
            ),
          ),
          Positioned(
            left: 0,
            top: 36,
            child: FloatingSoftMotion(
              child: _MiniChip(
                icon: Icons.school_outlined,
                label: 'School ERP',
                color: AppColors.accentBlue,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 48,
            child: FloatingSoftMotion(
              duration: const Duration(milliseconds: 3200),
              child: _MiniChip(
                icon: Icons.auto_awesome,
                label: 'AI Ready',
                color: AppColors.accentGoldDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardMock extends StatelessWidget {
  const _DashboardMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: AppColors.navyHero,
        boxShadow: AppShadows.elevated,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white.withValues(alpha: 0.06),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFFEBC2E)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF28C840)),
                const Spacer(),
                Text(
                  'ASOLTU · Admin Dashboard',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _metric('Attendance', '96.4%', Icons.fact_check_outlined)),
                      const SizedBox(width: 10),
                      Expanded(child: _metric('Fees', 'On track', Icons.payments_outlined)),
                      const SizedBox(width: 10),
                      Expanded(child: _metric('AI Insights', 'Ready', Icons.auto_awesome)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campus overview',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          for (final row in [
                            ('Admissions pipeline', 0.72),
                            ('Fee collection', 0.84),
                            ('Staff attendance', 0.91),
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    row.$1,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(99),
                                    child: LinearProgressIndicator(
                                      value: row.$2,
                                      minHeight: 6,
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.12),
                                      color: AppColors.accentGold,
                                    ),
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
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  Widget _metric(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.accentGold),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
