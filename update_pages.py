import re

with open('lib/features/products/presentation/pages.dart', 'r') as f:
    content = f.read()

new_pages = """
class DataHopPage extends StatelessWidget {
  const DataHopPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'DataHop',
      subtitle: 'Seamless Cross-Platform Connectivity',
      description: 'Transfer files, sync clipboards, and connect your devices instantly without cables or cloud storage. Local network speed, enterprise-grade security.',
      heroIcon: Icons.sync,
      imageAssets: ['assets/images/products/datahop_impressive.jpg'],
      downloads: [
        ProductDownload(
          label: 'Download for macOS',
          url: '/releases/DataHop-Mac-Installer.dmg',
          icon: Icons.apple,
        ),
        ProductDownload(
          label: 'Download for Windows',
          url: '/releases/DataHop-Windows-Setup.exe',
          icon: Icons.window,
        ),
      ],
      features: [
        ProductFeature(
          title: 'Lightning Fast',
          description: 'Uses your local Wi-Fi network for gigabit transfer speeds.',
          icon: Icons.speed,
        ),
        ProductFeature(
          title: 'Secure by Design',
          description: 'No cloud servers. Your files never leave your local network.',
          icon: Icons.security,
        ),
      ],
    );
  }
}

class DownloadManagerPage extends StatelessWidget {
  const DownloadManagerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'Asoltu Download Manager',
      subtitle: 'The Ultimate Download Accelerator',
      description: 'Boost your download speeds by up to 5x. Resume broken downloads, schedule queues, and manage all your files in one sleek interface.',
      heroIcon: Icons.download,
      imageAssets: ['assets/images/products/adm_impressive.jpg'],
      downloads: [
        ProductDownload(
          label: 'Download for macOS',
          url: '/releases/Asoltu-Download-Manager-1.0.0.dmg',
          icon: Icons.apple,
        ),
        ProductDownload(
          label: 'Download for Windows',
          url: '/releases/Asoltu-Download-Manager-Setup-1.0.0.exe',
          icon: Icons.window,
        ),
      ],
      features: [
        ProductFeature(
          title: 'Multi-threaded Downloads',
          description: 'Splits files into multiple parts to max out your bandwidth.',
          icon: Icons.call_split,
        ),
        ProductFeature(
          title: 'Smart Resume',
          description: 'Never lose progress. Automatically resume broken or interrupted downloads.',
          icon: Icons.replay,
        ),
      ],
    );
  }
}
"""

if "class DataHopPage" not in content:
    content += new_pages
    
    # Also inject them into the SoftwarePage hub
    hub_injection = """
        ProductFeature(
          title: 'DataHop',
          description: 'Seamless Cross-Platform File Transfer.',
          icon: Icons.sync,
          url: '/software/datahop',
        ),
        ProductFeature(
          title: 'Download Manager',
          description: 'High-speed download accelerator.',
          icon: Icons.download,
          url: '/software/download-manager',
        ),
    """
    content = content.replace(
        "url: '/software/i2droid',\n        ),",
        "url: '/software/i2droid',\n        )," + hub_injection
    )
    
    with open('lib/features/products/presentation/pages.dart', 'w') as f:
        f.write(content)
