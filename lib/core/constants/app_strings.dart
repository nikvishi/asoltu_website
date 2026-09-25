/// Marketing copy constants.
abstract final class AppStrings {
  AppStrings._();

  static const brandName = 'ASOLTU';
  static const companyLegal = 'ASOLTU Technologies';
  static const productName = 'ASOLTU School ERP';
  static const tagline = 'Building Intelligent Software for Schools & Businesses';
  static const brandMessage = 'Building Intelligent Software\nfor Schools & Businesses';
  static const brandSubheadline =
      'Enterprise-grade software powered by AI, Flutter and Cloud technologies.';

  static String get copyright =>
      '© ${DateTime.now().year} $companyLegal. All rights reserved.';

  /// Primary home document title (≤ ~60–70 chars for SERP).
  static const metaDefaultTitle =
      'ASOLTU Technologies | School ERP, Software Development, AI & Cloud';

  /// Primary home meta description.
  static const metaDefaultDescription =
      'ASOLTU Technologies builds intelligent School ERP, Flutter apps, web platforms, AI solutions and cloud software for schools and businesses across India.';

  /// Keyword list for meta keywords (supportive, not ranking factor).
  static const metaKeywords =
      'School ERP Software India, School ERP, School Management Software, '
      'School ERP Rajasthan, School ERP for CBSE Schools, School ERP for RBSE Schools, '
      'Education ERP, Student Management System, School Administration Software, '
      'School Automation Software, Software Development Company India, Flutter App Development, '
      'Web Development Company, Mobile App Development Company, Cloud Solutions, AI Solutions, '
      'Technology Company, Business Software, ERP Software, ASOLTU Technologies';

  static const serviceArea =
      'India — Rajasthan (Ramganj Mandi) and pan-India schools & businesses';

  static const orgPhoneDisplay = '+91-9462133119';
  static const orgEmail = 'info@asoltu.com';
  /// Legacy aliases used by SEO controller call sites.
  static const orgEmailSales = orgEmail;
  static const orgEmailSupport = orgEmail;
}
