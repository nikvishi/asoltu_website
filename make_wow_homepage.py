code = """
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

import '../../../../core/theme/theme_manager.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/layout/max_width_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgCanvas,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _BentoFeaturesSection(),
            const _CtaSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatefulWidget {
  const _HeroSection();
  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Container(
      width: double.infinity,
      color: context.bgCanvas,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Ambient Glow Background
          Positioned(
            top: -200,
            left: MediaQuery.of(context).size.width / 4,
            child: Container(
              width: 800,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: context.isDark ? 0.15 : 0.08),
                    const Color(0xFF8B5CF6).withValues(alpha: context.isDark ? 0.10 : 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Grid Pattern with fade
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.6, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Opacity(
                opacity: context.isDark ? 0.06 : 0.04,
                child: CustomPaint(painter: _HeroGridPainter(isDark: context.isDark)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 100 : 180),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  // Glowing Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: context.isDark ? Colors.white.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.1)),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.2), blurRadius: 20, spreadRadius: -5),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded, color: Color(0xFF3B82F6), size: 16),
                        const SizedBox(width: 8),
                        Text('Asoltu Tech 2.0 is Live', style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                  ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 32),

                  // Main Headline
                  Text(
                    'Building the Future of',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 40 : 72,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -2,
                      color: context.textPrimary,
                    ),
                  ).animate().fade(delay: 100.ms, duration: 800.ms).slideY(begin: 0.2),

                  // Animated Gradient Text
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFF3B82F6)],
                      stops: [0.0, 0.33, 0.66, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Software & Enterprise.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 40 : 72,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        letterSpacing: -2,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().fade(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 24),
                  Text(
                    'We craft premium cross-platform applications, secure data\\ntransfer protocols, and robust enterprise ERP systems.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 24,
                      color: context.textSecondary,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fade(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 48),
                  
                  // Action Buttons
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
                            boxShadow: [BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8))],
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
                            color: context.isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                            border: Border.all(color: context.border),
                          ),
                          child: Text('Open ERP Portal', style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
                        ),
                      ),
                    ],
                  ).animate().fade(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2),

                  const SizedBox(height: 80),
                  
                  // Floating Abstract UI (Wow Factor)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final floatValue = math.sin(_controller.value * 2 * math.pi) * 15;
                      return Transform.translate(
                        offset: Offset(0, floatValue),
                        child: child,
                      );
                    },
                    child: Container(
                      width: 800,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: context.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.isDark ? const Color(0xFF1E293B).withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.9),
                            context.isDark ? const Color(0xFF0F172A).withValues(alpha: 0.7) : const Color(0xFFF1F5F9).withValues(alpha: 0.9),
                          ]
                        ),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.15), blurRadius: 80, spreadRadius: 10),
                        ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Window Controls
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.border))),
                                child: Row(
                                  children: [
                                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
                                    const SizedBox(width: 8),
                                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                                    const SizedBox(width: 8),
                                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                                  ],
                                ),
                              ),
                              // Code/Dashboard mock lines
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _MockLine(width: 200, color: const Color(0xFF3B82F6).withValues(alpha: 0.8)),
                                      const SizedBox(height: 16),
                                      _MockLine(width: 400, color: context.textPrimary.withValues(alpha: 0.4)),
                                      const SizedBox(height: 12),
                                      _MockLine(width: 350, color: context.textPrimary.withValues(alpha: 0.4)),
                                      const SizedBox(height: 12),
                                      _MockLine(width: 500, color: context.textPrimary.withValues(alpha: 0.4)),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          Expanded(child: Container(height: 120, decoration: BoxDecoration(color: context.isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)))),
                                          const SizedBox(width: 16),
                                          Expanded(child: Container(height: 120, decoration: BoxDecoration(color: context.isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate().fade(delay: 500.ms, duration: 1.seconds).slideY(begin: 0.2),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockLine extends StatelessWidget {
  final double width;
  final Color color;
  const _MockLine({required this.width, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(width: width, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)));
  }
}

class _HeroGridPainter extends CustomPainter {
  final bool isDark;
  _HeroGridPainter({required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = isDark ? Colors.white : Colors.black..strokeWidth = 1.5;
    for (double i = 0; i < size.width; i += 60) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += 60) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
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
            Text('Our Ecosystem', style: TextStyle(color: context.primaryAccent, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 16)),
            const SizedBox(height: 16),
            Text('Simplify Complexity with Asoltu.', style: TextStyle(color: context.textPrimary, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.w900, letterSpacing: -1.5), textAlign: TextAlign.center),
            const SizedBox(height: 64),
            
            Wrap(
              spacing: 24, runSpacing: 24, alignment: WrapAlignment.center,
              children: [
                _BentoCard(
                  title: 'Asoltu - The Learning App',
                  description: 'Students desh ke sabhi exams ki practise ab ek jahgah ek app me kar sakte hai. Sabse secure live test system hai Asoltu ke paas.',
                  icon: Icons.menu_book_rounded,
                  width: isMobile ? double.infinity : 784,
                  height: 420,
                  isApp: true,
                  onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.asoltu.learning')),
                ),
                _BentoCard(
                  title: 'DataHop & i2droid',
                  description: 'Cross-platform file transfer and device integration ecosystem.',
                  icon: Icons.sync,
                  imagePath: 'assets/images/products/datahop_impressive.jpg',
                  width: isMobile ? double.infinity : 380,
                  height: 420,
                  onTap: () => context.go('/software/datahop'),
                ),
                _BentoCard(
                  title: 'Download Manager & Utilities',
                  description: 'Advanced document utilities and automation software.',
                  icon: Icons.picture_as_pdf,
                  imagePath: 'assets/images/products/adm_impressive.jpg',
                  width: isMobile ? double.infinity : 380,
                  height: 420,
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

class _BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? imagePath;
  final double width;
  final double height;
  final VoidCallback onTap;
  final bool isApp;

  const _BentoCard({required this.title, required this.description, required this.icon, this.imagePath, required this.width, required this.height, required this.onTap, this.isApp = false});

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.all(32),
          transform: Matrix4.translationValues(0, _isHovered ? -10 : 0, 0),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _isHovered ? context.primaryAccent.withValues(alpha: 0.5) : context.border, width: _isHovered ? 2 : 1),
            boxShadow: [
              if (_isHovered) BoxShadow(color: context.primaryAccent.withValues(alpha: 0.2), blurRadius: 40, offset: const Offset(0, 20))
              else BoxShadow(color: Colors.black.withValues(alpha: context.isDark ? 0.4 : 0.05), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: context.isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
                child: Icon(widget.icon, color: context.primaryAccent, size: 28),
              ),
              if (widget.imagePath != null) ...[
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(widget.imagePath!, fit: BoxFit.cover, width: double.infinity, alignment: Alignment.topCenter),
                    ),
                  ),
                ),
              ] else if (widget.isApp) ...[
                const Spacer(),
                Wrap(
                  spacing: 16, runSpacing: 16,
                  children: [
                    InkWell(
                      onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.asoltu.learning')),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.play_arrow_rounded, color: Colors.white),
                            const SizedBox(width: 8),
                            const Text('Get on Play Store', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ]
                        )
                      )
                    ),
                    InkWell(
                      onTap: () => launchUrl(Uri.parse('https://apps.apple.com/us/app/asoltu-tutorials/id6449000000')),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(color: context.isDark ? Colors.white : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.apple, color: context.isDark ? Colors.black : Colors.black),
                            const SizedBox(width: 8),
                            Text('Get on App Store', style: TextStyle(color: context.isDark ? Colors.black : Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                          ]
                        )
                      )
                    ),
                  ]
                )
              ] else ...[
                const Spacer(),
              ],
              const SizedBox(height: 32),
              Text(widget.title, style: TextStyle(color: context.textPrimary, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              const SizedBox(height: 12),
              Text(widget.description, style: TextStyle(color: context.textSecondary, fontSize: 17, height: 1.5)),
            ],
          ),
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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2563EB), Color(0xFF4F46E5), Color(0xFF7C3AED)]
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.3), blurRadius: 40, offset: const Offset(0, 20)),
            ]
          ),
          child: Column(
            children: [
              Text('Ready to transform your workflow?', style: TextStyle(color: Colors.white, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.w900, letterSpacing: -1.5), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Text('Join thousands of users building the future with Asoltu Tech.', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 20), textAlign: TextAlign.center),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  elevation: 10,
                  shadowColor: Colors.black.withValues(alpha: 0.2),
                ),
                child: const Text('Get Started For Free', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
