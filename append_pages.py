with open('lib/features/products/presentation/pages.dart', 'a') as f:
    f.write('''

class I2DroidPage extends StatelessWidget {
  const I2DroidPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'i2droid',
      subtitle: 'The Hopp Project',
      description: 'An advanced Android utility that bridges the gap between your devices. Seamlessly transfer files, manage data, and connect your ecosystem.',
      heroIcon: Icons.android,
      imageAssets: ['assets/images/products/hopp_1.png', 'assets/images/products/hopp_2.png'],
      downloads: [
        ProductDownload(
          label: 'Download APK',
          url: '/releases/i2droid.apk',
          icon: Icons.android,
        ),
      ],
      features: [
        ProductFeature(
          title: 'Cross-Device Sync',
          description: 'Keep your data consistent across your mobile and desktop ecosystem.',
          icon: Icons.sync,
        ),
        ProductFeature(
          title: 'Secure Transfer',
          description: 'Local network transfers that never touch the cloud.',
          icon: Icons.security,
        ),
      ],
    );
  }
}

class AsoltuAppPage extends StatelessWidget {
  const AsoltuAppPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'Asoltu',
      subtitle: 'The Absolute Tutorials App',
      description: 'The official Asoltu mobile app for students. Access courses, track progress, and learn on the go with our premium educational platform.',
      heroIcon: Icons.school,
      imageAssets: ['assets/images/products/asoltu_app_1.png'],
      downloads: [
        ProductDownload(
          label: 'Download on App Store',
          url: 'https://apps.apple.com/app/asoltu', // Placeholder, user will update if needed
          icon: Icons.apple,
        ),
        ProductDownload(
          label: 'Get it on Google Play',
          url: 'https://play.google.com/store/apps/details?id=com.asoltu.app', // Placeholder
          icon: Icons.android,
        ),
      ],
      features: [
        ProductFeature(
          title: 'Mobile Learning',
          description: 'Take your courses anywhere with our optimized mobile experience.',
          icon: Icons.phone_android,
        ),
        ProductFeature(
          title: 'Progress Tracking',
          description: 'Monitor your completion rates and test scores in real-time.',
          icon: Icons.trending_up,
        ),
      ],
    );
  }
}
''')

# Now add them to the hubs
with open('lib/features/products/presentation/pages.dart', 'r') as f:
    content = f.read()

content = content.replace(
    "url: '/software/pdf-o',\n        ),\n      ],",
    "url: '/software/pdf-o',\n        ),\n        ProductFeature(\n          title: 'i2droid',\n          description: 'The Hopp project - advanced Android connectivity.',\n          icon: Icons.android,\n          url: '/software/i2droid',\n        ),\n      ],"
)

content = content.replace(
    "url: '/education/exam-series',\n        ),\n      ],",
    "url: '/education/exam-series',\n        ),\n        ProductFeature(\n          title: 'Asoltu App',\n          description: 'The Absolute Tutorials mobile app for students.',\n          icon: Icons.smartphone,\n          url: '/education/asoltu-app',\n        ),\n      ],"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(content)

