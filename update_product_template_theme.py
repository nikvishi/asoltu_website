import re

with open('lib/features/products/presentation/product_landing_template.dart', 'r') as f:
    content = f.read()

# Make all hardcoded colors responsive to brightness
replacement_hero = r"""
  Widget _buildHero(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF030712) : const Color(0xFFF8FAFC),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Linear style grid overlay
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.05 : 0.03,
              child: CustomPaint(
                painter: GridPainter(isDark: isDark),
              ),
            ),
          ),
          
          // Background animated glow
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: isMobile ? 200 : 400,
                  height: isMobile ? 200 : 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        isDark ? const Color(0xFF3B82F6).withValues(alpha: 0.15) : const Color(0xFF3B82F6).withValues(alpha: 0.1),
                        isDark ? const Color(0xFF8B5CF6).withValues(alpha: 0.1) : const Color(0xFF8B5CF6).withValues(alpha: 0.05),
                        Colors.transparent,
                      ]
                    ),
                  ),
                ),
              );
            },
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 60 : 120),
            child: MaxWidthContainer(
              child: Column(
                children: [
                  // Glassmorphism icon container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.02),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.02),
                              blurRadius: 20,
                            )
                          ]
                        ),
                        child: Icon(widget.heroIcon, size: isMobile ? 48 : 64, color: isDark ? Colors.white : const Color(0xFF111827)),
                      ),
                    ),
                  ).animate().scale(delay: 100.ms, duration: 600.ms, curve: Curves.easeOutBack),
                  
                  SizedBox(height: isMobile ? 32 : 48),
                  
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                          fontSize: isMobile ? 40 : 64,
                          height: 1.1,
                        ),
                    textAlign: TextAlign.center,
                  ).animate().fade(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  
                  const SizedBox(height: 16),
                  
                  // Gradient subtitle text
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: isDark 
                          ? [const Color(0xFF60A5FA), const Color(0xFFA78BFA)]
                          : [const Color(0xFF2563EB), const Color(0xFF7C3AED)],
                    ).createShader(bounds),
                    child: Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white, // required for ShaderMask to render properly
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 18 : 24,
                            letterSpacing: -0.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ).animate().fade(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  
                  SizedBox(height: isMobile ? 24 : 32),
                  
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF475569),
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            fontSize: isMobile ? 16 : 20,
                          ),
                    ),
                  ).animate().fade(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  
                  SizedBox(height: isMobile ? 32 : 48),
                  
                  _buildActionButtons(isMobile, isDark).animate().fade(delay: 500.ms, duration: 800.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1,1), curve: Curves.easeOut),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isMobile, bool isDark) {
"""

content = re.sub(r'  Widget _buildHero\(BuildContext context\) \{.*?Widget _buildActionButtons\(bool isMobile\) \{', replacement_hero, content, flags=re.DOTALL)

# Fix _buildActionButtons
action_btns = r"""Widget _buildActionButtons(bool isMobile, bool isDark) {
    if (widget.downloads.isNotEmpty) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: widget.downloads.map((d) => _buildPremiumButton(
          label: d.label,
          icon: d.icon,
          isPrimary: true,
          isDark: isDark,
          onPressed: () => launchUrl(Uri.parse(d.url)),
        )).toList(),
      );
    }
    
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        if (widget.primaryActionLabel != null)
          _buildPremiumButton(
            label: widget.primaryActionLabel!,
            isPrimary: true,
            isDark: isDark,
            onPressed: () {
              if (widget.primaryActionUrl != null) {
                if (widget.primaryActionUrl!.startsWith('http')) {
                  launchUrl(Uri.parse(widget.primaryActionUrl!));
                } else {
                  context.go(widget.primaryActionUrl!);
                }
              }
            },
          ),
        if (widget.secondaryActionLabel != null)
          _buildPremiumButton(
            label: widget.secondaryActionLabel!,
            isPrimary: false,
            isDark: isDark,
            onPressed: () {
              if (widget.secondaryActionUrl != null) {
                if (widget.secondaryActionUrl!.startsWith('http')) {
                  launchUrl(Uri.parse(widget.secondaryActionUrl!));
                } else {
                  context.go(widget.secondaryActionUrl!);
                }
              }
            },
          ),
      ],
    );
  }

  Widget _buildPremiumButton({required String label, IconData? icon, required bool isPrimary, required bool isDark, required VoidCallback onPressed}) {"""
content = re.sub(r'  Widget _buildActionButtons\(bool isMobile, bool isDark\) \{.*?Widget _buildPremiumButton\(\{required String label, IconData\? icon, required bool isPrimary, required VoidCallback onPressed\}\) \{', action_btns, content, flags=re.DOTALL)

# Fix _buildPremiumButton styling
premium_btn = r"""Widget _buildPremiumButton({required String label, IconData? icon, required bool isPrimary, required bool isDark, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: isPrimary ? const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
          ) : null,
          color: isPrimary ? null : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
          border: isPrimary ? null : Border.all(color: isDark ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.1)),
          boxShadow: isPrimary ? [
            BoxShadow(
              color: const Color(0xFF4F46E5).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: isPrimary ? Colors.white : (isDark ? Colors.white : Colors.black), size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : (isDark ? Colors.white : Colors.black),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }"""
content = re.sub(r'  Widget _buildPremiumButton\(\{.*?\}\) \{.*?\}\s*\}', premium_btn, content, flags=re.DOTALL)

# Fix _buildShowcase
showcase = r"""
  Widget _buildShowcase(BuildContext context) {
    if (widget.imageAssets.isEmpty) return const SizedBox.shrink();
    
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 60 : 120),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Interface Overview',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    letterSpacing: -1,
                  ),
              textAlign: TextAlign.center,
            ).animate().fade().slideY(),
            const SizedBox(height: 48),
            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: widget.imageAssets.map((asset) => _buildImageMockup(asset, isDark)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageMockup(String assetPath, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.1),
            blurRadius: 40,
            offset: const Offset(0, 20),
          )
        ],
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    ).animate().fade(duration: 800.ms).scale(begin: const Offset(0.9, 0.9));
  }"""
content = re.sub(r'  Widget _buildShowcase\(BuildContext context\) \{.*?\}\s*\}', showcase, content, flags=re.DOTALL)


# Fix _buildFeatures
features = r"""
  Widget _buildFeatures(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      color: isDark ? const Color(0xFF030712) : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 60 : 120),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Key Features',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                    letterSpacing: -1,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Everything you need in a modern application.',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: widget.features.map((f) => _buildFeatureCard(context, f, isDark)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, ProductFeature feature, bool isDark) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      width: isMobile ? double.infinity : 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.2) : const Color(0xFF111827).withValues(alpha: 0.03),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(feature.icon, size: 28, color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF374151)),
          ),
          const SizedBox(height: 24),
          Text(
            feature.title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
              letterSpacing: -0.5,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            feature.description,
            style: TextStyle(
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              height: 1.6,
              fontSize: 16,
            ),
          ),
          if (feature.url != null) ...[
            const SizedBox(height: 32),
            InkWell(
              onTap: () {
                if (feature.url!.startsWith('http')) {
                  launchUrl(Uri.parse(feature.url!));
                } else {
                  context.go(feature.url!);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    feature.actionLabel ?? 'Learn more',
                    style: TextStyle(
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB)),
                ],
              ),
            ),
          ]
        ],
      ),
    ).animate().fade(duration: 600.ms).slideY(begin: 0.1);
  }
}

class GridPainter extends CustomPainter {
  final bool isDark;
  GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..strokeWidth = 1;
      
    final double spacing = 40;
    
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
"""
content = re.sub(r'  Widget _buildFeatures\(BuildContext context\) \{.*?\}\s*\}\s*class GridPainter extends CustomPainter \{.*?\}', features, content, flags=re.DOTALL)

with open('lib/features/products/presentation/product_landing_template.dart', 'w') as f:
    f.write(content)
