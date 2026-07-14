import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/route_names.dart';
import '../../theme/app_colors.dart';

/// Accessible breadcrumb trail for marketing pages.
class PageBreadcrumb extends StatelessWidget {
  const PageBreadcrumb({
    super.key,
    required this.current,
    this.parentLabel,
    this.parentRoute,
  });

  final String current;
  final String? parentLabel;
  final String? parentRoute;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Breadcrumb',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _Crumb(
            label: 'Home',
            onTap: () => context.go(AppRoutes.home),
          ),
          const _Sep(),
          if (parentLabel != null && parentRoute != null) ...[
            _Crumb(
              label: parentLabel!,
              onTap: () => context.go(parentRoute!),
            ),
            const _Sep(),
          ],
          Text(
            current,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.brandNavy,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _Crumb extends StatelessWidget {
  const _Crumb({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.accentBlue,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _Sep extends StatelessWidget {
  const _Sep();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textMuted),
    );
  }
}
