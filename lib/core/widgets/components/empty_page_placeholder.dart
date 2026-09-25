import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_urls.dart';
import '../../routing/route_names.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'asoltu_button.dart';
import 'section_heading.dart';
import '../layout/page_section.dart';

/// Fallback content for unexpected empty states (not used for primary routes).
class EmptyPagePlaceholder extends StatelessWidget {
  const EmptyPagePlaceholder({
    super.key,
    required this.title,
    this.subtitle =
        'This section is available from the main navigation. Return home or contact our team for help.',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return PageSection(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: Column(
        children: [
          SectionHeading(
            eyebrow: 'ASOLTU',
            title: title,
            subtitle: subtitle,
            center: true,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              AsoltuButton(
                label: 'Go home',
                onPressed: () => context.go(AppRoutes.home),
              ),
              AsoltuButton(
                label: 'Contact',
                variant: AsoltuButtonVariant.secondary,
                onPressed: () => context.go(AppRoutes.contact),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Need help? ${AppUrls.infoEmailDisplay}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
        ],
      ),
    );
  }
}
