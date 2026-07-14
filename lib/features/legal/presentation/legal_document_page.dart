import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/widgets.dart';

/// Reusable long-form legal document layout.
class LegalDocumentPage extends StatelessWidget {
  const LegalDocumentPage({
    super.key,
    required this.title,
    required this.sections,
    this.eyebrow = 'Legal',
  });

  final String title;
  final String eyebrow;
  final List<(String, String)> sections;

  @override
  Widget build(BuildContext context) {
    return PageSection(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              child: SectionHeading(
                eyebrow: eyebrow,
                title: title,
                subtitle:
                    'Last updated: 14 July 2026 · ${AppStrings.companyLegal}',
              ),
            ),
            const SizedBox(height: 28),
            for (final s in sections) ...[
              Text(
                s.$1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.brandNavy,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                s.$2,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.65,
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 22),
            ],
            Text(
              'Questions: support@asoltu.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.brandNavy,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
