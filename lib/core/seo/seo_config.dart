import '../constants/app_strings.dart';
import '../constants/app_urls.dart';
import '../routing/route_names.dart';

/// Per-route SEO metadata for the corporate site.
class SeoMeta {
  const SeoMeta({
    required this.title,
    required this.description,
    this.path = '/',
    this.noIndex = false,
  });

  final String title;
  final String description;
  final String path;
  final bool noIndex;

  String get canonicalUrl => '${AppUrls.marketingSite}$path';

  String get fullTitle => path == AppRoutes.home
      ? title
      : '$title · ${AppStrings.brandName}';
}

/// SEO registry for every marketing route.
abstract final class SeoConfig {
  SeoConfig._();

  static const defaultMeta = SeoMeta(
    title: AppStrings.metaDefaultTitle,
    description: AppStrings.metaDefaultDescription,
    path: AppRoutes.home,
  );

  /// Home uses the same default meta (optimized for Phase 4.2).

  static final Map<String, SeoMeta> byPath = {
    AppRoutes.home: defaultMeta,
    AppRoutes.products: const SeoMeta(
      title: 'Products — School ERP, Parent App, AI & More',
      description:
          'ASOLTU products: School ERP, Coaching ERP, College ERP, Multi Campus, Teacher/Parent/Student apps, HR, Finance, Attendance, Exams, Transport, Hostel, Library, AI Assistant.',
      path: AppRoutes.products,
    ),
    AppRoutes.solutions: const SeoMeta(
      title: 'Solutions — Schools, Coaching, Colleges & Groups',
      description:
          'ASOLTU solutions for schools, coaching institutes, colleges, education groups, international schools, and smart campuses — problems vs solutions.',
      path: AppRoutes.solutions,
    ),
    AppRoutes.pricing: const SeoMeta(
      title: 'Pricing',
      description:
          'ASOLTU School ERP pricing — Starter, Professional, Enterprise, and Education Group plans. Book a free demo.',
      path: AppRoutes.pricing,
    ),
    AppRoutes.about: const SeoMeta(
      title: 'About',
      description:
          'Learn about ASOLTU Tech Solutions and our mission in education technology.',
      path: AppRoutes.about,
    ),
    AppRoutes.resources: const SeoMeta(
      title: 'Resources',
      description:
          'Guides, whitepapers, and resources for school leaders and IT teams.',
      path: AppRoutes.resources,
    ),
    AppRoutes.blog: const SeoMeta(
      title: 'Blog',
      description:
          'Insights on school operations, SaaS, and digital transformation in education.',
      path: AppRoutes.blog,
    ),
    AppRoutes.contact: const SeoMeta(
      title: 'Contact',
      description: 'Talk to ASOLTU sales and support about School ERP for your institution.',
      path: AppRoutes.contact,
    ),
    AppRoutes.careers: const SeoMeta(
      title: 'Careers',
      description: 'Join ASOLTU — build the future of school management software.',
      path: AppRoutes.careers,
    ),
    AppRoutes.privacy: const SeoMeta(
      title: 'Privacy Policy',
      description: 'How ASOLTU collects, uses, and protects personal data.',
      path: AppRoutes.privacy,
    ),
    AppRoutes.terms: const SeoMeta(
      title: 'Terms of Service',
      description: 'Terms governing use of ASOLTU products and services.',
      path: AppRoutes.terms,
    ),
    AppRoutes.refund: const SeoMeta(
      title: 'Refund Policy',
      description: 'ASOLTU subscription and services refund policy.',
      path: AppRoutes.refund,
    ),
    AppRoutes.cookies: const SeoMeta(
      title: 'Cookie Policy',
      description: 'How ASOLTU uses cookies and similar technologies on asoltu.com.',
      path: AppRoutes.cookies,
    ),
    AppRoutes.dataProtection: const SeoMeta(
      title: 'Data Protection',
      description:
          'How ASOLTU protects marketing leads and multi-tenant school ERP data — security, retention, and rights.',
      path: AppRoutes.dataProtection,
    ),
    AppRoutes.disclaimer: const SeoMeta(
      title: 'Disclaimer',
      description:
          'Important disclaimers for ASOLTU marketing content, product descriptions, and website use.',
      path: AppRoutes.disclaimer,
    ),
    AppRoutes.documentation: const SeoMeta(
      title: 'Documentation',
      description: 'Product documentation and implementation guides for ASOLTU School ERP.',
      path: AppRoutes.documentation,
    ),
    AppRoutes.support: const SeoMeta(
      title: 'Support',
      description: 'Get help with ASOLTU School ERP — helpdesk, FAQs, and contact options.',
      path: AppRoutes.support,
    ),
    AppRoutes.login: const SeoMeta(
      title: 'Login',
      description: 'Sign in to ASOLTU School ERP at erp.asoltu.com.',
      path: AppRoutes.login,
      noIndex: true,
    ),
  };

  static SeoMeta forPath(String path) => byPath[path] ?? defaultMeta;
}
