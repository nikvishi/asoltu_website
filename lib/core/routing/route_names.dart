/// Canonical route paths for the marketing site.
abstract final class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const products = '/products';
  static const solutions = '/solutions';
  static const pricing = '/pricing';
  static const about = '/about';
  static const resources = '/resources';
  static const blog = '/blog';
  static const contact = '/contact';
  static const careers = '/careers';
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const refund = '/refund';
  static const cookies = '/cookies';
  static const dataProtection = '/data-protection';
  static const disclaimer = '/disclaimer';
  static const documentation = '/documentation';
  static const support = '/support';
  static const login = '/login';
}

/// Human-readable labels for nav + SEO.
abstract final class AppRouteLabels {
  AppRouteLabels._();

  static const Map<String, String> titles = {
    AppRoutes.home: 'Home',
    AppRoutes.products: 'Products',
    AppRoutes.solutions: 'Solutions',
    AppRoutes.pricing: 'Pricing',
    AppRoutes.about: 'About',
    AppRoutes.resources: 'Resources',
    AppRoutes.blog: 'Blog',
    AppRoutes.contact: 'Contact',
    AppRoutes.careers: 'Careers',
    AppRoutes.privacy: 'Privacy Policy',
    AppRoutes.terms: 'Terms of Service',
    AppRoutes.refund: 'Refund Policy',
    AppRoutes.cookies: 'Cookie Policy',
    AppRoutes.dataProtection: 'Data Protection',
    AppRoutes.disclaimer: 'Disclaimer',
    AppRoutes.documentation: 'Documentation',
    AppRoutes.support: 'Support',
    AppRoutes.login: 'Login',
  };
}
