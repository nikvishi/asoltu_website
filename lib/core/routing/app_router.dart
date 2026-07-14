import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/presentation/about_page.dart';
import '../../features/auth/presentation/login_redirect_page.dart';
import '../../features/blog/presentation/blog_page.dart';
import '../../features/careers/presentation/careers_page.dart';
import '../../features/contact/presentation/contact_page.dart';
import '../../features/docs/presentation/documentation_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/legal/presentation/cookies_page.dart';
import '../../features/legal/presentation/data_protection_page.dart';
import '../../features/legal/presentation/disclaimer_page.dart';
import '../../features/legal/presentation/privacy_page.dart';
import '../../features/legal/presentation/refund_page.dart';
import '../../features/legal/presentation/terms_page.dart';
import '../../features/pricing/presentation/pricing_page.dart';
import '../../features/products/presentation/products_page.dart';
import '../../features/resources/presentation/resources_page.dart';
import '../../features/solutions/presentation/solutions_page.dart';
import '../../features/support/presentation/support_page.dart';
import '../animations/page_transitions.dart';
import '../seo/seo_config.dart';
import '../seo/seo_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/layout/marketing_scroll_body.dart';
import '../widgets/layout/site_scaffold.dart';
import 'route_names.dart';

/// GoRouter configuration for the ASOLTU marketing website.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: false,
  redirect: (context, state) {
    // Apply SEO for the matched path (non-blocking).
    final path = state.uri.path;
    final meta = SeoConfig.forPath(path);
    // Schedule after frame so document is ready on web.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SeoController.apply(meta);
    });
    return null;
  },
  errorBuilder: (context, state) => SiteScaffold(
    child: MarketingScrollBody(
      child: EmptyNotFound(path: state.uri.path),
    ),
  ),
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // Login uses a minimal shell (no marketing chrome).
        if (state.uri.path == AppRoutes.login) {
          return child;
        }
        return SiteScaffold(child: child);
      },
      routes: [
        _page(AppRoutes.home, const HomePage()),
        _page(AppRoutes.products, const ProductsPage()),
        _page(AppRoutes.solutions, const SolutionsPage()),
        _page(AppRoutes.pricing, const PricingPage()),
        _page(AppRoutes.about, const AboutPage()),
        _page(AppRoutes.resources, const ResourcesPage()),
        _page(AppRoutes.blog, const BlogPage()),
        _page(AppRoutes.contact, const ContactPage()),
        _page(AppRoutes.careers, const CareersPage()),
        _page(AppRoutes.privacy, const PrivacyPage()),
        _page(AppRoutes.terms, const TermsPage()),
        _page(AppRoutes.refund, const RefundPage()),
        _page(AppRoutes.cookies, const CookiesPage()),
        _page(AppRoutes.dataProtection, const DataProtectionPage()),
        _page(AppRoutes.disclaimer, const DisclaimerPage()),
        _page(AppRoutes.documentation, const DocumentationPage()),
        _page(AppRoutes.support, const SupportPage()),
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          pageBuilder: (context, state) => fadeSlidePage(
            key: state.pageKey,
            child: const LoginRedirectPage(),
          ),
        ),
      ],
    ),
  ],
);

GoRoute _page(String path, Widget child) {
  final name = path == '/' ? 'home' : path.replaceAll('/', '');
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (context, state) => fadeSlidePage(
      key: state.pageKey,
      child: MarketingScrollBody(child: child),
    ),
  );
}

class EmptyNotFound extends StatelessWidget {
  const EmptyNotFound({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: 'Page not found',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '404',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.brandNavy,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'This page does not exist',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.brandNavy,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  path.isEmpty
                      ? 'The link may be outdated or mistyped.'
                      : 'We could not find “$path”. Try the homepage or contact sales.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () => context.go(AppRoutes.home),
                      child: const Text('Go home'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go(AppRoutes.contact),
                      child: const Text('Contact'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go(AppRoutes.products),
                      child: const Text('Products'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
