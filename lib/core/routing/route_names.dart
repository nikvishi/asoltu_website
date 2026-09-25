/// Canonical route paths for the marketing site.
abstract final class AppRoutes {
  AppRoutes._();

  static const home = '/';
  
  // High-Level Navigation
  static const products = '/products';
  static const education = '/education';
  static const software = '/software';
  static const business = '/business';
  
  // Specific Landing Pages
  static const examSeries = '/education/exam-series';
  static const schoolErp = '/business/school-erp';
  static const downloadManager = '/software/download-manager';
  static const dataHop = '/software/datahop';
  static const asoltuRemote = '/software/asoltu-remote';
  static const pdfO = '/software/pdf-o';
  static const khataBahi = '/software/khata-bahi';
  static const i2droid = '/software/i2droid';
  static const asoltuApp = '/education/asoltu-app';

  // Utilities
  static const downloads = '/downloads';
  static const blog = '/blog';
  static const support = '/support';
  static const about = '/about';
  
  // Legal
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const refund = '/refund';
  static const cookies = '/cookies';
  static const dataProtection = '/data-protection';
  static const disclaimer = '/disclaimer';
  
  // Legacy / Misc
  static const contact = '/contact';
  static const careers = '/careers';
  static const documentation = '/documentation';
  static const login = '/login';
}

/// Human-readable labels for nav + SEO.
abstract final class AppRouteLabels {
  AppRouteLabels._();

  static const Map<String, String> titles = {
    AppRoutes.home: 'Home',
    AppRoutes.products: 'Products',
    AppRoutes.education: 'Education',
    AppRoutes.software: 'Software',
    AppRoutes.business: 'Business Solutions',
    AppRoutes.downloads: 'Downloads',
    AppRoutes.blog: 'Blog',
    AppRoutes.support: 'Support',
    AppRoutes.about: 'About',
    
    // Landings
    AppRoutes.examSeries: 'Exam Series',
    AppRoutes.schoolErp: 'School ERP',
    AppRoutes.downloadManager: 'Download Manager',
    AppRoutes.dataHop: 'DataHop',
    AppRoutes.asoltuRemote: 'AsoltuRemote',
    AppRoutes.pdfO: 'PDF-O',
    AppRoutes.i2droid: 'i2Droid',
    AppRoutes.asoltuApp: 'Asoltu App',

    // Legal & Misc
    AppRoutes.privacy: 'Privacy Policy',
    AppRoutes.terms: 'Terms of Service',
    AppRoutes.refund: 'Refund Policy',
    AppRoutes.cookies: 'Cookie Policy',
    AppRoutes.dataProtection: 'Data Protection',
    AppRoutes.disclaimer: 'Disclaimer',
    AppRoutes.contact: 'Contact',
    AppRoutes.careers: 'Careers',
    AppRoutes.documentation: 'Documentation',
    AppRoutes.login: 'Login',
  };
}
