/// External and internal URLs for the ASOLTU corporate site.
/// ERP lives on a separate subdomain — never merge the two apps.
abstract final class AppUrls {
  AppUrls._();

  static const marketingSite = 'https://asoltu.com';
  static const erpPortal = 'https://erp.asoltu.com';

  /// Primary public contact email (only address used on the marketing site).
  static const infoEmailDisplay = 'info@asoltu.com';
  static const infoEmail = 'mailto:info@asoltu.com';

  /// Legacy aliases — all resolve to [infoEmail] for existing call sites.
  static const supportEmailDisplay = infoEmailDisplay;
  static const salesEmailDisplay = infoEmailDisplay;
  static const supportEmail = infoEmail;
  static const salesEmail = infoEmail;

  static const careersEmailDisplay = 'careers@asoltu.com';
  static const careersEmail = 'mailto:careers@asoltu.com';

  /// Public contact numbers for marketing CTAs.
  static const phoneDisplay = '+91-9462133119';
  static const phoneTel = 'tel:+919462133119';
  static const whatsApp = 'https://wa.me/919462133119';

  static const businessHours = 'Monday to Saturday, 10:00 AM – 7:00 PM IST';
  static const officeName = 'ASOLTU Technologies';
  static const officeAddress =
      'RMA, Ramganj Mandi, Rajasthan, India';
  static const officeAddressFull =
      'ASOLTU Technologies, RMA, Ramganj Mandi, Rajasthan, India';

  /// Google Maps — Ramganj Mandi, Rajasthan.
  static const googleMapsSearch =
      'https://www.google.com/maps/search/?api=1&query=Ramganj+Mandi+Rajasthan+India';
  static const googleMapsDirections =
      'https://www.google.com/maps/dir/?api=1&destination=Ramganj+Mandi+Rajasthan+India';
  static const googleMapsEmbed =
      'https://maps.google.com/maps?q=Ramganj+Mandi+Rajasthan+India&t=&z=14&ie=UTF8&iwloc=&output=embed';

  static const linkedIn = 'https://www.linkedin.com/company/asoltu';
  static const twitter = 'https://x.com/asoltu';
  static const youtube = 'https://www.youtube.com/@asoltu';
  static const facebook = 'https://www.facebook.com/asoltu';
  static const github = 'https://github.com/asoltu';

  static const docsBase = 'https://docs.asoltu.com';
  static const statusPage = 'https://status.asoltu.com';
}
