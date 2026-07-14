import 'package:flutter/foundation.dart';

/// Integration points for marketing analytics.
///
/// IDs are intentionally empty — set them before production analytics go live.
/// Never put secrets here.
abstract final class AnalyticsHooks {
  AnalyticsHooks._();

  /// Google Analytics 4 Measurement ID (e.g. G-XXXXXXXX).
  static const String ga4MeasurementId = '';

  /// Google Search Console verification meta content.
  static const String searchConsoleVerification = '';

  /// Meta (Facebook) Pixel ID.
  static const String metaPixelId = '';

  /// LinkedIn Insight Tag partner ID.
  static const String linkedInPartnerId = '';

  static bool get ga4Ready => ga4MeasurementId.isNotEmpty;
  static bool get metaPixelReady => metaPixelId.isNotEmpty;
  static bool get linkedInReady => linkedInPartnerId.isNotEmpty;

  /// Call after a successful lead conversion.
  static void trackLeadSubmitted(String formName) {
    debugPrint('[Analytics] lead_submitted form=$formName');
    // GA4 / Meta / LinkedIn hooks go here when IDs are configured.
  }

  static void trackCtaClick(String ctaName) {
    debugPrint('[Analytics] cta_click name=$ctaName');
  }

  static void trackDemoBooked() {
    debugPrint('[Analytics] demo_booked');
  }

  /// Snippet helpers for index.html (documentation only).
  static String get setupNotes => '''
Analytics setup (asoltu_website only):
1. Set AnalyticsHooks.ga4MeasurementId and inject gtag in web/index.html
2. Add Search Console meta: AnalyticsHooks.searchConsoleVerification
3. Add Meta Pixel when metaPixelId is set
4. Add LinkedIn Insight when linkedInPartnerId is set
ERP analytics remain separate.
''';
}
