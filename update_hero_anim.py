import re

with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    content = f.read()

impressive_anim = """
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
"""
content = re.sub(r'  late AnimationController _animController;.*?void dispose\(\) \{ _animController\.dispose\(\); super\.dispose\(\); \}', impressive_anim + "  @override\n  void dispose() { _animController.dispose(); super.dispose(); }", content, flags=re.DOTALL)

stack_bg = """
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Orb 1
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
                  // Orb 2
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
                  // Orb 3
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
"""

content = re.sub(r'          AnimatedBuilder\([\s\S]*?,\s*\),[\s\S]*?Padding\(', stack_bg + "\n          Padding(", content)

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(content)
