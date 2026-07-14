import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import 'floating_soft_motion.dart';

/// Premium hero — Stripe/Linear style entrance + dashboard mockup.
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
        ? 34.0
        : w < Breakpoints.tablet
            ? 42.0
            : 54.0;

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
                'AI-POWERED SCHOOL ERP',
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
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Run your entire school\n',
                style: TextStyle(
                  fontSize: size,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                  letterSpacing: -1.0,
                  color: AppColors.brandNavy,
                ),
              ),
              TextSpan(
                text: 'on one intelligent platform.',
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
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 480.ms)
            .slideY(begin: 0.08, end: 0, duration: 480.ms),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'ASOLTU is the AI-powered school ERP for admissions, attendance, fees, '
            'academics, HR, and parent communication — secure, cloud-native, and built for scale.',
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
              label: 'Start Free Demo',
              icon: Icons.rocket_launch_outlined,
              onPressed: () => launchUrl(
                Uri.parse(AppUrls.erpPortal),
                mode: LaunchMode.externalApplication,
              ),
            ),
            AsoltuButton(
              label: 'Book Live Demo',
              variant: AsoltuButtonVariant.secondary,
              icon: Icons.calendar_month_outlined,
              onPressed: () => showBookDemoDialog(context),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms)
            .slideY(begin: 0.1, end: 0, duration: 400.ms),
        const SizedBox(height: 20),
        Text(
          'No credit card required · Live in minutes · Multi-campus ready',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
        ).animate().fadeIn(delay: 280.ms, duration: 400.ms),
      ],
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
              amplitude: 7,
              child: const _FloatCard(
                icon: Icons.groups_rounded,
                label: 'Students',
                value: '12.4k',
                color: AppColors.accentBlue,
              ),
            ).animate().fadeIn(delay: 260.ms, duration: 400.ms),
          ),
          Positioned(
            right: 0,
            top: 72,
            child: FloatingSoftMotion(
              amplitude: 9,
              duration: const Duration(milliseconds: 3100),
              child: const _FloatCard(
                icon: Icons.payments_outlined,
                label: 'Fees',
                value: '₹2.1Cr',
                color: AppColors.accentGold,
              ),
            ).animate().fadeIn(delay: 320.ms, duration: 400.ms),
          ),
          Positioned(
            left: 8,
            bottom: 24,
            child: FloatingSoftMotion(
              amplitude: 6,
              duration: const Duration(milliseconds: 2700),
              child: const _FloatCard(
                icon: Icons.fact_check_outlined,
                label: 'Attendance',
                value: '96.2%',
                color: AppColors.success,
              ),
            ).animate().fadeIn(delay: 380.ms, duration: 400.ms),
          ),
          Positioned(
            right: 12,
            bottom: 48,
            child: FloatingSoftMotion(
              amplitude: 8,
              duration: const Duration(milliseconds: 3300),
              child: const _FloatCard(
                icon: Icons.insights_outlined,
                label: 'AI Insights',
                value: 'Live',
                color: AppColors.brandNavy,
              ),
            ).animate().fadeIn(delay: 440.ms, duration: 400.ms),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 160.ms, duration: 520.ms)
        .scale(begin: const Offset(0.96, 0.96), duration: 520.ms);
  }
}

class _DashboardMock extends StatelessWidget {
  const _DashboardMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.elevated,
      ),
      child: Column(
        children: [
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFFEBC2E)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF28C840)),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    height: 24,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Text(
                      'erp.asoltu.com · Dashboard',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _kpi('Revenue', '₹48.2L', 0.78)),
                      const SizedBox(width: 10),
                      Expanded(child: _kpi('Present', '94%', 0.94)),
                      const SizedBox(width: 10),
                      Expanded(child: _kpi('Admits', '128', 0.62)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSoft,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Performance analytics',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppColors.brandNavy,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                const Expanded(
                                  child: CustomPaint(
                                    painter: _MiniChartPainter(),
                                    child: SizedBox.expand(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                child: _side(
                                  Icons.auto_awesome,
                                  'AI Reports',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: _side(
                                  Icons.chat_bubble_outline,
                                  'Messages',
                                ),
                              ),
                            ],
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
    );
  }

  Widget _dot(Color c) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  Widget _kpi(String label, String value, double p) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: p,
              minHeight: 5,
              backgroundColor: Colors.white,
              color: AppColors.accentBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _side(IconData icon, String label) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.accentBlue, size: 22),
          const SizedBox(height: 6),
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

class _FloatCard extends StatelessWidget {
  const _FloatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.brandNavy,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  const _MiniChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final line = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    const points = [0.25, 0.4, 0.32, 0.62, 0.5, 0.78, 0.7, 0.92];
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = size.width * (i / (points.length - 1));
      final y = size.height * (1 - points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, line);
    final fill = Path()
      ..addPath(path, Offset.zero)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.accentBlue.withValues(alpha: 0.2),
            AppColors.accentBlue.withValues(alpha: 0.0),
          ],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
