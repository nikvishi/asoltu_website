code = """
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/theme_manager.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/layout/max_width_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _NewHeroSection(),
        const _BentoFeaturesSection(),
        const _CtaSection(),
      ],
    );
  }
}

class _NewHeroSection extends StatefulWidget {
  const _NewHeroSection();
  @override
  State<_NewHeroSection> createState() => _NewHeroSectionState();
}

class _NewHeroSectionState extends State<_NewHeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine));
    _rotateAnimation = Tween<double>(begin: 0, end: 2 * 3.14159265359).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Container(
      width: double.infinity,
      color: context.bgCanvas,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: context.isDark ? 0.05 : 0.03,
              child: CustomPaint(painter: _GridPainter(isDark: context.isDark)),
            ),
          ),
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(40 * _pulseAnimation.value, -30 * _pulseAnimation.value),
                    child: Transform.rotate(
                      angle: _rotateAnimation.value,
                      child: Container(
                        width: isMobile ? 300 : 600, height: isMobile ? 300 : 600,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              context.isDark ? const Color(0xFF3B82F6).withValues(alpha: 0.15) : const Color(0xFF3B82F6).withValues(alpha: 0.12),
                              Colors.transparent,
                            ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-50 * _pulseAnimation.value, 40 * _pulseAnimation.value),
                    child: Transform.rotate(
                      angle: -_rotateAnimation.value * 1.5,
                      child: Container(
                        width: isMobile ? 250 : 500, height: isMobile ? 250 : 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              context.isDark ? const Color(0xFF8B5CF6).withValues(alpha: 0.15) : const Color(0xFF8B5CF6).withValues(alpha: 0.10),
                              Colors.transparent,
                            ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: isMobile ? 400 : 800, height: isMobile ? 150 : 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            context.isDark ? const Color(0xFF06B6D4).withValues(alpha: 0.1) : const Color(0xFF06B6D4).withValues(alpha: 0.08),
                            Colors.transparent,
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 80 : 160),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: context.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text('Asoltu Tech v2.0 is Live', style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                  ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 32),
                  Text(
                    'Building the Future of\\nSoftware & Enterprise Solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 40 : 72,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -2,
                      color: context.textPrimary,
                    ),
                  ).animate().fade(delay: 100.ms, duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 24),
                  Text(
                    'We craft premium cross-platform applications, secure data\\ntransfer protocols, and robust enterprise ERP systems.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 24,
                      color: context.textSecondary,
                      height: 1.5,
                    ),
                  ).animate().fade(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 16, runSpacing: 16, alignment: WrapAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => context.go('/products'),
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF4F46E5)]),
                            boxShadow: [BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
                          ),
                          child: const Text('Explore Our Suite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                        ),
                      ),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse('https://asoltuschoolerp.web.app')),
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: context.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                            border: Border.all(color: context.border),
                          ),
                          child: Text('Open ERP Portal', style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
                        ),
                      ),
                    ],
                  ).animate().fade(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final bool isDark;
  _GridPainter({required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = isDark ? Colors.white : Colors.black..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += 40) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BentoFeaturesSection extends StatelessWidget {
  const _BentoFeaturesSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: context.bgCanvas,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 60 : 120),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text('Our Solutions', style: TextStyle(color: context.primaryAccent, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 16),
            Text('Simplify Complexity with Asoltu.', style: TextStyle(color: context.textPrimary, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.w900, letterSpacing: -1.5), textAlign: TextAlign.center),
            const SizedBox(height: 64),
            
            Wrap(
              spacing: 24, runSpacing: 24, alignment: WrapAlignment.center,
              children: [
                _BentoCard(
                  title: 'School ERP',
                  description: 'End-to-end campus management system with real-time analytics.',
                  icon: Icons.school,
                  width: isMobile ? double.infinity : 380,
                  height: 380,
                  onTap: () => context.go('/education/exam-series'),
                ),
                _BentoCard(
                  title: 'DataHop & i2droid',
                  description: 'Cross-platform file transfer and device integration ecosystem.',
                  icon: Icons.sync,
                  imagePath: 'assets/images/products/datahop_impressive.jpg',
                  width: isMobile ? double.infinity : 380,
                  height: 380,
                  onTap: () => context.go('/software/datahop'),
                ),
                _BentoCard(
                  title: 'Download Manager & Utilities',
                  description: 'Advanced document utilities and automation software.',
                  icon: Icons.picture_as_pdf,
                  imagePath: 'assets/images/products/adm_impressive.jpg',
                  width: isMobile ? double.infinity : 784,
                  height: 380,
                  onTap: () => context.go('/software/download-manager'),
                ),
              ],
            ).animate().fade(duration: 800.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? imagePath;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _BentoCard({required this.title, required this.description, required this.icon, this.imagePath, required this.width, required this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: width, height: height,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: context.isDark ? 0.2 : 0.05), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: context.isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: context.primaryAccent, size: 28),
            ),
            if (imagePath != null) ...[
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imagePath!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ] else ...[
              const Spacer(),
            ],
            const SizedBox(height: 16),
            Text(title, style: TextStyle(color: context.textPrimary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: context.textSecondary, fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _CtaSection extends StatelessWidget {
  const _CtaSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      color: context.bgCanvas,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 60 : 120),
      child: MaxWidthContainer(
        child: Container(
          padding: EdgeInsets.all(isMobile ? 32 : 64),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF4F46E5)]),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              Text('Ready to transform your workflow?', style: TextStyle(color: Colors.white, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold, letterSpacing: -1), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Text('Join thousands of users building the future with Asoltu Tech.', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 18), textAlign: TextAlign.center),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: const Text('Get Started For Free', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
"""

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
