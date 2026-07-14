import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class TrustSection extends StatelessWidget {
  const TrustSection({super.key});

  static const _institutions = [
    ('Schools', Icons.account_balance_outlined),
    ('Coaching Institutes', Icons.menu_book_outlined),
    ('Colleges', Icons.school_outlined),
    ('Education Groups', Icons.apartment_outlined),
    ('International Boards', Icons.public_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      backgroundColor: AppColors.surfaceMuted,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            'TRUSTED BY INSTITUTIONS',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Built for modern education leaders',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              for (var i = 0; i < _institutions.length; i++)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _institutions[i].$2,
                        size: 18,
                        color: AppColors.accentBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _institutions[i].$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brandNavy,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: (60 * i).ms, duration: 350.ms)
                    .slideY(begin: 0.1, end: 0, duration: 350.ms),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'From single campuses to multi-branch education groups',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
