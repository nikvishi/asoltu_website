with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# First replace the _BentoFeaturesSection
new_bento_features = """
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
                  onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.absolutetutorials.app')),
                ),
                _BentoCard(
                  title: 'DataHop & i2droid',
                  description: 'Cross-platform file transfer and device integration ecosystem.',
                  icon: Icons.sync,
                  customVisual: const _DataHopVisual(),
                  width: isMobile ? double.infinity : 380,
                  height: 420,
                  onTap: () => context.go('/software/datahop'),
                ),
                _BentoCard(
                  title: 'Download Manager',
                  description: 'Advanced document utilities and automation software.',
                  icon: Icons.cloud_download_rounded,
                  customVisual: const _DownloadManagerVisual(),
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
"""

import re
code = re.sub(r'class _BentoFeaturesSection extends StatelessWidget \{.*?\n\}\n(?=class _BentoCard)', new_bento_features, code, flags=re.DOTALL)


# Then replace the _BentoCard and add visuals
new_bento_card_and_visuals = """
class _BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Widget? customVisual;
  final double width;
  final double height;
  final VoidCallback onTap;
  final bool isApp;

  const _BentoCard({required this.title, required this.description, required this.icon, this.customVisual, required this.width, required this.height, required this.onTap, this.isApp = false});

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
              if (widget.customVisual != null) ...[
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: widget.customVisual!,
                  ),
                ),
              ] else if (widget.isApp) ...[
                const Spacer(),
                Wrap(
                  spacing: 16, runSpacing: 16,
                  children: [
                    InkWell(
                      onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.absolutetutorials.app')),
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
                      onTap: () => launchUrl(Uri.parse('https://apps.apple.com/in/app/asoltu/id6796294470')),
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

class _DataHopVisual extends StatelessWidget {
  const _DataHopVisual();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.border)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.smartphone, size: 64, color: context.isDark ? Colors.white54 : Colors.black54),
              const SizedBox(width: 20),
              Container(
                width: 60, height: 2,
                color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
              ),
              const SizedBox(width: 20),
              Icon(Icons.laptop_mac, size: 80, color: context.isDark ? Colors.white54 : Colors.black54),
            ],
          ),
          Positioned(
            child: Icon(Icons.sync, color: const Color(0xFF3B82F6), size: 32).animate(onPlay: (c) => c.repeat()).rotate(duration: 2.seconds),
          )
        ],
      )
    );
  }
}

class _DownloadManagerVisual extends StatelessWidget {
  const _DownloadManagerVisual();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.border)
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.file_present_rounded, color: const Color(0xFF8B5CF6), size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 8, width: 100, decoration: BoxDecoration(color: context.textPrimary.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(height: 4, width: double.infinity, decoration: BoxDecoration(color: context.border, borderRadius: BorderRadius.circular(2))),
                          Container(height: 4, width: 80, decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(2))),
                        ],
                      )
                    ],
                  )
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.file_present_rounded, color: const Color(0xFF10B981), size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 8, width: 140, decoration: BoxDecoration(color: context.textPrimary.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 8),
                      Container(height: 4, width: double.infinity, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(2))),
                    ],
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
}
"""

code = re.sub(r'class _BentoCard extends StatefulWidget \{.*?\n\}\n\nclass _CtaSection', new_bento_card_and_visuals + "\n\nclass _CtaSection", code, flags=re.DOTALL)

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
