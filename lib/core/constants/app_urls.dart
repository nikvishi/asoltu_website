/// External and internal URLs for the ASOLTU corporate site.
/// ERP lives on a separate subdomain — never merge the two apps.
abstract final class AppUrls {
  AppUrls._();

  static const marketingSite = 'https://asoltu.com';
  static const erpPortal = 'https://erp.asoltu.com';

  static const supportEmailDisplay = 'support@asoltu.com';
  static const salesEmailDisplay = 'sales@asoltu.com';
  static const careersEmailDisplay = 'careers@asoltu.com';

  static const supportEmail = 'mailto:support@asoltu.com';
  static const salesEmail = 'mailto:sales@asoltu.com';
  static const careersEmail = 'mailto:careers@asoltu.com';

  /// Public contact numbers for marketing CTAs (update when numbers change).
  static const phoneDisplay = '+91 99999 99999';
  static const phoneTel = 'tel:+919999999999';
  static const whatsApp = 'https://wa.me/919999999999';

  static const businessHours = 'Mon–Fri, 10:00–18:00 IST';
  static const officeAddress = 'India · Registered office details available on request';
  static const googleMapsSearch =
      'https://www.google.com/maps/search/?api=1&query=ASOLTU+Tech+Solutions+India';

  static const linkedIn = 'https://www.linkedin.com/company/asoltu';
  static const twitter = 'https://x.com/asoltu';
  static const youtube = 'https://www.youtube.com/@asoltu';
  static const facebook = 'https://www.facebook.com/asoltu';
  static const github = 'https://github.com/asoltu';

  static const docsBase = 'https://docs.asoltu.com';
  static const statusPage = 'https://status.asoltu.com';
}
