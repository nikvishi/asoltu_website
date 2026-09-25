import 'package:flutter/material.dart';

import '../../../../core/seo/seo_faq_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  /// Visible FAQ — aligned with FAQPage JSON-LD (SeoFaqData.homepage).
  static List<(String, String)> get faqs => SeoFaqData.homepage;

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'FAQ',
              title: 'School ERP FAQs',
              subtitle:
                  'Answers about School ERP software, CBSE & RBSE schools, parent apps, Android support, offline use, demos and security.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              children: [
                for (final faq in faqs)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _FaqTile(question: faq.$1, answer: faq.$2),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'FAQ: $question',
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.borderLight),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
            iconColor: AppColors.accentBlue,
            collapsedIconColor: AppColors.brandNavy,
            shape: const Border(),
            collapsedShape: const Border(),
            title: Text(
              question,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.brandNavy,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  answer,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.55,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
