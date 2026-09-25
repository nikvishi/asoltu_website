import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  static const _groups = <(String, List<String>)>[
    (
      'Languages',
      [
        'Dart',
        'Java',
        'Kotlin',
        'Swift',
        'Python',
        'JavaScript',
        'TypeScript',
        'PHP',
      ],
    ),
    (
      'Frameworks',
      [
        'Flutter',
        'Flutter Web',
        'Node.js',
        'Firebase',
        'REST APIs',
        'Cloud Functions',
      ],
    ),
    (
      'Databases',
      [
        'Firestore',
        'MySQL',
        'PostgreSQL',
      ],
    ),
    (
      'Platforms',
      [
        'Android',
        'iOS',
        'Windows',
        'macOS',
        'Linux',
        'Web',
      ],
    ),
    (
      'Cloud',
      [
        'Firebase',
        'Google Cloud',
        'Cloud Storage',
        'Cloud Messaging',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Technology stack',
              title: 'Built with modern engineering tools',
              subtitle:
                  'A professional stack for cross-platform products, secure cloud backends and scalable deployments.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1000
                  ? 3
                  : c.maxWidth >= 640
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _groups.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 2.2 : 1.35,
                ),
                itemBuilder: (context, i) {
                  final g = _groups[i];
                  return Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          g.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.brandNavy,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final item in g.$2)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceMuted,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.pill),
                                    border: Border.all(
                                      color: AppColors.borderLight,
                                    ),
                                  ),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppColors.brandNavy,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
