import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_urls.dart';
import '../../theme/app_colors.dart';

/// Social icon row for footer / contact.
class SocialLinks extends StatelessWidget {
  const SocialLinks({
    super.key,
    this.onNavy = false,
    this.iconSize = 20,
  });

  final bool onNavy;
  final double iconSize;

  static const _items = [
    (Icons.work_outline, AppUrls.linkedIn, 'LinkedIn'),
    (Icons.alternate_email, AppUrls.twitter, 'X / Twitter'),
    (Icons.play_circle_outline, AppUrls.youtube, 'YouTube'),
    (Icons.public, AppUrls.facebook, 'Facebook'),
  ];

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = onNavy ? Colors.white70 : AppColors.textSecondary;

    return Wrap(
      spacing: 4,
      children: [
        for (final item in _items)
          IconButton(
            tooltip: item.$3,
            onPressed: () => _open(item.$2),
            icon: Icon(item.$1, size: iconSize, color: color),
          ),
        IconButton(
          tooltip: 'GitHub',
          onPressed: () => _open(AppUrls.github),
          icon: Icon(Icons.code, size: iconSize, color: color),
        ),
      ],
    );
  }
}
