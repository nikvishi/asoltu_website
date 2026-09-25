// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;

import '../constants/app_strings.dart';
import '../constants/app_urls.dart';
import '../routing/route_names.dart';
import 'seo_config.dart';
import 'seo_faq_data.dart';

const _ogImage = 'https://asoltu.com/icons/Icon-512.png';
const _logoUrl = 'https://asoltu.com/icons/Icon-512.png';

void applySeo(SeoMeta meta) {
  html.document.title = meta.fullTitle;

  _setMeta('description', meta.description);
  _setMeta('keywords', meta.keywordSet);
  _setMeta('author', AppStrings.companyLegal);
  _setMeta(
    'robots',
    meta.noIndex
        ? 'noindex, nofollow'
        : 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
  );
  _setMeta('googlebot', meta.noIndex ? 'noindex, nofollow' : 'index, follow');
  _setMeta('bingbot', meta.noIndex ? 'noindex, nofollow' : 'index, follow');
  _setMeta('geo.region', 'IN-RJ');
  _setMeta('geo.placename', 'India');
  _setMeta('language', 'English');
  _setMeta('revisit-after', '7 days');

  // Open Graph
  _setProperty('og:title', meta.fullTitle);
  _setProperty('og:description', meta.description);
  _setProperty('og:url', meta.canonicalUrl);
  _setProperty('og:type', meta.ogType == 'blog' ? 'website' : meta.ogType);
  _setProperty('og:site_name', 'ASOLTU Technologies');
  _setProperty('og:image', _ogImage);
  _setProperty(
    'og:image:alt',
    'ASOLTU Technologies — intelligent software for schools and businesses',
  );
  _setProperty('og:locale', 'en_IN');

  // Twitter Cards
  _setMeta('twitter:card', 'summary_large_image');
  _setMeta('twitter:title', meta.fullTitle);
  _setMeta('twitter:description', meta.description);
  _setMeta('twitter:image', _ogImage);
  _setMeta('twitter:image:alt', 'ASOLTU Technologies');

  _setCanonical(meta.canonicalUrl);
  _setAlternateHreflang('en-IN', meta.canonicalUrl);
  _setAlternateHreflang('x-default', meta.canonicalUrl);

  _setBreadcrumbJsonLd(meta);
  _setPageJsonLd(meta);
}

void _setMeta(String name, String content) {
  final existing = html.document.querySelector('meta[name="$name"]');
  if (existing != null) {
    existing.setAttribute('content', content);
    return;
  }
  final el = html.MetaElement()
    ..name = name
    ..content = content;
  html.document.head?.append(el);
}

void _setProperty(String property, String content) {
  final existing = html.document.querySelector('meta[property="$property"]');
  if (existing != null) {
    existing.setAttribute('content', content);
    return;
  }
  final el = html.MetaElement()
    ..setAttribute('property', property)
    ..content = content;
  html.document.head?.append(el);
}

void _setCanonical(String href) {
  final existing = html.document.querySelector('link[rel="canonical"]');
  if (existing != null) {
    existing.setAttribute('href', href);
    return;
  }
  final el = html.LinkElement()
    ..rel = 'canonical'
    ..href = href;
  html.document.head?.append(el);
}

void _setAlternateHreflang(String lang, String href) {
  final sel = 'link[rel="alternate"][hreflang="$lang"]';
  final existing = html.document.querySelector(sel);
  if (existing != null) {
    existing.setAttribute('href', href);
    return;
  }
  final el = html.LinkElement()
    ..rel = 'alternate'
    ..setAttribute('hreflang', lang)
    ..href = href;
  html.document.head?.append(el);
}

void _upsertScript(String id, Map<String, Object?> payload) {
  html.document.getElementById(id)?.remove();
  final script = html.ScriptElement()
    ..id = id
    ..type = 'application/ld+json'
    ..text = jsonEncode(payload);
  html.document.head?.append(script);
}

void _setBreadcrumbJsonLd(SeoMeta meta) {
  final items = <Map<String, Object>>[
    {
      '@type': 'ListItem',
      'position': 1,
      'name': 'Home',
      'item': '${AppUrls.marketingSite}/',
    },
  ];

  if (meta.path != '/' && meta.path.isNotEmpty) {
    items.add({
      '@type': 'ListItem',
      'position': 2,
      'name': meta.title,
      'item': meta.canonicalUrl,
    });
  }

  _upsertScript('asoltu-breadcrumb-jsonld', {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    'itemListElement': items,
  });
}

Map<String, Object?> _organization() => {
      '@type': ['Organization', 'Corporation'],
      '@id': '${AppUrls.marketingSite}/#organization',
      'name': AppStrings.companyLegal,
      'alternateName': ['ASOLTU', 'ASOLTU School ERP'],
      'url': AppUrls.marketingSite,
      'logo': {
        '@type': 'ImageObject',
        'url': _logoUrl,
        'width': 512,
        'height': 512,
      },
      'image': _logoUrl,
      'description': AppStrings.metaDefaultDescription,
      'email': AppStrings.orgEmail,
      'telephone': AppStrings.orgPhoneDisplay,
      'address': {
        '@type': 'PostalAddress',
        'streetAddress': 'RMA',
        'addressLocality': 'Ramganj Mandi',
        'addressRegion': 'Rajasthan',
        'addressCountry': 'IN',
      },
      'areaServed': {
        '@type': 'Country',
        'name': 'India',
      },
      'knowsAbout': [
        'School ERP Software',
        'School Management Software',
        'Flutter App Development',
        'Web Development',
        'Cloud Solutions',
        'AI Solutions',
        'Custom Software Development',
      ],
      'sameAs': [
        AppUrls.linkedIn,
        AppUrls.twitter,
        AppUrls.youtube,
        AppUrls.facebook,
      ],
      'contactPoint': [
        {
          '@type': 'ContactPoint',
          'contactType': 'customer service',
          'email': AppStrings.orgEmail,
          'telephone': AppStrings.orgPhoneDisplay,
          'areaServed': 'IN',
          'availableLanguage': ['English', 'Hindi'],
        },
      ],
    };

Map<String, Object?> _localBusiness() => {
      '@type': 'ProfessionalService',
      '@id': '${AppUrls.marketingSite}/#localbusiness',
      'name': AppStrings.companyLegal,
      'image': _logoUrl,
      'url': AppUrls.marketingSite,
      'telephone': AppStrings.orgPhoneDisplay,
      'email': AppStrings.orgEmail,
      'address': {
        '@type': 'PostalAddress',
        'streetAddress': 'RMA',
        'addressLocality': 'Ramganj Mandi',
        'addressRegion': 'Rajasthan',
        'addressCountry': 'IN',
      },
      'areaServed': [
        {'@type': 'Country', 'name': 'India'},
        {'@type': 'State', 'name': 'Rajasthan'},
      ],
      'openingHoursSpecification': {
        '@type': 'OpeningHoursSpecification',
        'dayOfWeek': [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
        ],
        'opens': '10:00',
        'closes': '19:00',
      },
      'sameAs': [AppUrls.linkedIn, AppUrls.twitter],
      'parentOrganization': {'@id': '${AppUrls.marketingSite}/#organization'},
    };

Map<String, Object?> _website() => {
      '@type': 'WebSite',
      '@id': '${AppUrls.marketingSite}/#website',
      'name': 'ASOLTU Technologies',
      'alternateName': 'ASOLTU',
      'url': AppUrls.marketingSite,
      'description': AppStrings.metaDefaultDescription,
      'publisher': {'@id': '${AppUrls.marketingSite}/#organization'},
      'inLanguage': 'en-IN',
    };

Map<String, Object?> _softwareApplication() => {
      '@type': 'SoftwareApplication',
      '@id': '${AppUrls.marketingSite}/#school-erp',
      'name': 'ASOLTU School ERP',
      'applicationCategory': 'BusinessApplication',
      'applicationSubCategory': 'School Management Software',
      'operatingSystem': 'Web, Android, iOS, Windows, macOS, Linux',
      'url': '${AppUrls.marketingSite}/solutions',
      'image': _logoUrl,
      'description':
          'School ERP software for admissions, attendance, fees, exams, HR, parent apps and analytics. Built for Indian schools including CBSE and RBSE workflows.',
      'provider': {'@id': '${AppUrls.marketingSite}/#organization'},
      'featureList': [
        'Admissions',
        'Attendance',
        'Fees',
        'Examinations',
        'HR & Payroll',
        'Parent App',
        'AI Reports',
        'Multi-campus',
      ],
      'audience': {
        '@type': 'EducationalAudience',
        'educationalRole': 'administrator',
      },
    };

Map<String, Object?> _faqPage(List<(String, String)> faqs) => {
      '@type': 'FAQPage',
      '@id': '${AppUrls.marketingSite}/#faq',
      'mainEntity': [
        for (final f in faqs)
          {
            '@type': 'Question',
            'name': f.$1,
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': f.$2,
            },
          },
      ],
    };

void _setPageJsonLd(SeoMeta meta) {
  // Allowlist only: Organization, ProfessionalService, Website, WebPage,
  // SoftwareApplication, BreadcrumbList (separate), FAQPage. No Product schema.
  final graph = <Map<String, Object?>>[
    _organization(),
    _localBusiness(),
    _website(),
    _softwareApplication(),
    {
      '@type': 'WebPage',
      '@id': '${meta.canonicalUrl}#webpage',
      'name': meta.fullTitle,
      'description': meta.description,
      'url': meta.canonicalUrl,
      'inLanguage': 'en-IN',
      'isPartOf': {'@id': '${AppUrls.marketingSite}/#website'},
      'about': {'@id': '${AppUrls.marketingSite}/#school-erp'},
      'publisher': {'@id': '${AppUrls.marketingSite}/#organization'},
      'primaryImageOfPage': {
        '@type': 'ImageObject',
        'url': _ogImage,
      },
    },
  ];

  if (meta.path == '/' ||
      meta.path == AppRoutes.home ||
      meta.path == '/support' ||
      meta.path == '/solutions') {
    graph.add(_faqPage(SeoFaqData.primary));
  }

  if (meta.path == '/blog') {
    graph.add({
      '@type': 'Blog',
      '@id': '${AppUrls.marketingSite}/blog#blog',
      'name': 'ASOLTU Blog',
      'url': '${AppUrls.marketingSite}/blog',
      'description': meta.description,
      'publisher': {'@id': '${AppUrls.marketingSite}/#organization'},
    });
  }

  if (meta.path == '/about') {
    graph.add({
      '@type': 'AboutPage',
      'name': meta.fullTitle,
      'url': meta.canonicalUrl,
      'mainEntity': {'@id': '${AppUrls.marketingSite}/#organization'},
    });
  }

  if (meta.path == '/contact') {
    graph.add({
      '@type': 'ContactPage',
      'name': meta.fullTitle,
      'url': meta.canonicalUrl,
    });
  }

  _upsertScript('asoltu-page-jsonld', {
    '@context': 'https://schema.org',
    '@graph': graph,
  });
}
