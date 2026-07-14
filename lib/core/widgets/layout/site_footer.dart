import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_strings.dart';
import '../../constants/app_urls.dart';
import '../../routing/route_names.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../utils/form_validators.dart';
import '../components/asoltu_button.dart';
import '../components/brand_logo.dart';
import '../components/social_links.dart';
import 'max_width_container.dart';

/// Premium site footer: product, solutions, resources, company, legal, newsletter.
class SiteFooter extends StatefulWidget {
  const SiteFooter({super.key});

  @override
  State<SiteFooter> createState() => _SiteFooterState();
}

class _SiteFooterState extends State<SiteFooter> {
  final _email = TextEditingController();
  bool _done = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _subscribe() {
    final err = FormValidators.email(_email.text);
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    setState(() => _done = true);
  }

  void _backToTop() {
    final controller = PrimaryScrollController.maybeOf(context);
    controller?.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 900;

    return ColoredBox(
      color: AppColors.brandNavyDark,
      child: MaxWidthContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNarrow) ...[
                const BrandLogo(onNavy: true, height: 36),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.tagline,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                const SocialLinks(onNavy: true),
                const SizedBox(height: 28),
                _newsletterBlock(),
                const SizedBox(height: 28),
                const _FooterColumn(
                  title: 'Products',
                  links: [
                    ('Products', AppRoutes.products),
                    ('Pricing', AppRoutes.pricing),
                    ('Documentation', AppRoutes.documentation),
                  ],
                ),
                const SizedBox(height: 22),
                const _FooterColumn(
                  title: 'Solutions',
                  links: [
                    ('Solutions', AppRoutes.solutions),
                    ('Support', AppRoutes.support),
                  ],
                ),
                const SizedBox(height: 22),
                const _FooterColumn(
                  title: 'Resources',
                  links: [
                    ('Resources', AppRoutes.resources),
                    ('Blog', AppRoutes.blog),
                    ('Documentation', AppRoutes.documentation),
                  ],
                ),
                const SizedBox(height: 22),
                const _FooterColumn(
                  title: 'Company',
                  links: [
                    ('About', AppRoutes.about),
                    ('Careers', AppRoutes.careers),
                    ('Contact', AppRoutes.contact),
                  ],
                ),
                const SizedBox(height: 22),
                const _FooterColumn(
                  title: 'Legal',
                  links: [
                    ('Privacy', AppRoutes.privacy),
                    ('Terms', AppRoutes.terms),
                    ('Refund', AppRoutes.refund),
                    ('Cookies', AppRoutes.cookies),
                    ('Data Protection', AppRoutes.dataProtection),
                    ('Disclaimer', AppRoutes.disclaimer),
                  ],
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandLogo(onNavy: true, height: 36),
                          const SizedBox(height: 12),
                          const Text(
                            AppStrings.tagline,
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          const SocialLinks(onNavy: true),
                          const SizedBox(height: 24),
                          _newsletterBlock(),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Products',
                        links: [
                          ('Products', AppRoutes.products),
                          ('Pricing', AppRoutes.pricing),
                          ('Documentation', AppRoutes.documentation),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Solutions',
                        links: [
                          ('Solutions', AppRoutes.solutions),
                          ('Support', AppRoutes.support),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Resources',
                        links: [
                          ('Resources', AppRoutes.resources),
                          ('Blog', AppRoutes.blog),
                          ('Documentation', AppRoutes.documentation),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Company',
                        links: [
                          ('About', AppRoutes.about),
                          ('Careers', AppRoutes.careers),
                          ('Contact', AppRoutes.contact),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: _FooterColumn(
                        title: 'Legal',
                        links: [
                          ('Privacy', AppRoutes.privacy),
                          ('Terms', AppRoutes.terms),
                          ('Refund', AppRoutes.refund),
                          ('Cookies', AppRoutes.cookies),
                          ('Data Protection', AppRoutes.dataProtection),
                          ('Disclaimer', AppRoutes.disclaimer),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
              const Divider(color: Colors.white24),
              const SizedBox(height: AppSpacing.lg),
              LayoutBuilder(
                builder: (context, c) {
                  final stack = c.maxWidth < 640;
                  final copy = Column(
                    crossAxisAlignment: stack
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.copyright,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'ERP portal: erp.asoltu.com · Marketing: asoltu.com',
                        style: TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppUrls.salesEmailDisplay} · ${AppUrls.supportEmailDisplay}',
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  );
                  final top = TextButton.icon(
                    onPressed: _backToTop,
                    icon: const Icon(Icons.arrow_upward_rounded,
                        color: AppColors.accentGold, size: 18),
                    label: const Text(
                      'Back to top',
                      style: TextStyle(
                        color: AppColors.accentGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                  if (stack) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [copy, top],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: copy),
                      top,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newsletterBlock() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Newsletter',
            style: TextStyle(
              color: AppColors.accentGold,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Product and school-ops insights.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          if (_done)
            const Text(
              'Thanks — you are subscribed.',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Work email',
                      hintStyle: const TextStyle(color: Colors.white38),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AsoltuButton(
                  label: 'Join',
                  variant: AsoltuButtonVariant.gold,
                  onPressed: _subscribe,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.links});

  final String title;
  final List<(String, String)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: AppColors.accentGold,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        for (final link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => context.go(link.$2),
              child: Text(
                link.$1,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
