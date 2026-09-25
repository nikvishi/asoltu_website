with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

import re

# We will just redefine the BentoCard usage in _BentoFeaturesSection
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

code = re.sub(r'class _BentoFeaturesSection extends StatelessWidget \{.*?\n\}\n(?=class _BentoCard)', new_bento_features, code, flags=re.DOTALL)

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
