import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Traditional school software vs ASOLTU comparison.
class WhyAsoltuSection extends StatelessWidget {
  const WhyAsoltuSection({super.key});

  static const _rows = <(String, String, String)>[
    ('Data', 'Spreadsheets & silos', 'Unified live school data'),
    ('Access', 'Desktop-only tools', 'Web, mobile & multi-campus'),
    ('Fees', 'Manual collection chaos', 'Automated billing & receipts'),
    ('Parents', 'Scattered WhatsApp groups', 'Secure parent portal'),
    ('Insights', 'Month-end reports', 'AI-powered real-time analytics'),
    ('Scale', 'Hard to grow', 'Multi-tenant SaaS ready'),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        children: [
          const FadeIn(
            child: SectionHeading(
              eyebrow: 'Why ASOLTU',
              title: 'Leave traditional software behind',
              subtitle:
                  'A clear upgrade path from fragmented school tools to a modern AI-powered ERP.',
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 860;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: AppShadows.soft,
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Header
                    if (wide)
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: _headerCell(
                              'Traditional School',
                              AppColors.textSecondary,
                              false,
                            ),
                          ),
                          Expanded(
                            child: _headerCell(
                              'ASOLTU',
                              AppColors.accentBlue,
                              true,
                            ),
                          ),
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _headerCell(
                                'Traditional',
                                AppColors.textSecondary,
                                false,
                              ),
                            ),
                            Expanded(
                              child: _headerCell(
                                'ASOLTU',
                                AppColors.accentBlue,
                                true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Divider(height: 1),
                    for (var i = 0; i < _rows.length; i++)
                      _ComparisonRow(
                        label: _rows[i].$1,
                        traditional: _rows[i].$2,
                        asoltu: _rows[i].$3,
                        wide: wide,
                        index: i,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String title, Color color, bool emphasize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      color: emphasize
          ? AppColors.accentBlue.withValues(alpha: 0.06)
          : Colors.transparent,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: color,
        ),
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.label,
    required this.traditional,
    required this.asoltu,
    required this.wide,
    required this.index,
  });

  final String label;
  final String traditional;
  final String asoltu;
  final bool wide;
  final int index;

  @override
  Widget build(BuildContext context) {
    final row = wide
        ? Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandNavy,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.close_rounded,
                          size: 16, color: AppColors.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          traditional,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.accentBlue.withValues(alpha: 0.04),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 16, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          asoltu,
                          style: const TextStyle(
                            color: AppColors.brandNavy,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.brandNavy,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.close_rounded,
                        size: 16, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        traditional,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        size: 16, color: AppColors.success),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        asoltu,
                        style: const TextStyle(
                          color: AppColors.brandNavy,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderLight.withValues(alpha: 0.9),
          ),
        ),
      ),
      child: row
          .animate()
          .fadeIn(delay: (70 * index).ms, duration: 350.ms)
          .slideX(begin: 0.02, end: 0, duration: 350.ms),
    );
  }
}
