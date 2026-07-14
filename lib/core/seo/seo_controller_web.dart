// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;

import 'seo_config.dart';

void applySeo(SeoMeta meta) {
  html.document.title = meta.fullTitle;
  _setMeta('description', meta.description);
  _setMeta('robots', meta.noIndex ? 'noindex, nofollow' : 'index, follow');
  _setMeta('twitter:card', 'summary_large_image');
  _setMeta('twitter:title', meta.fullTitle);
  _setMeta('twitter:description', meta.description);
  _setMeta('twitter:image', 'https://asoltu.com/icons/Icon-512.png');

  _setProperty('og:title', meta.fullTitle);
  _setProperty('og:description', meta.description);
  _setProperty('og:url', meta.canonicalUrl);
  _setProperty('og:type', meta.path == '/blog' ? 'article' : 'website');
  _setProperty('og:site_name', 'ASOLTU');
  _setProperty('og:image', 'https://asoltu.com/icons/Icon-512.png');
  _setProperty('og:locale', 'en_IN');
  _setProperty('twitter:card', 'summary_large_image');
  _setProperty('twitter:title', meta.fullTitle);
  _setProperty('twitter:description', meta.description);
  _setProperty('twitter:image', 'https://asoltu.com/icons/Icon-512.png');

  _setCanonical(meta.canonicalUrl);
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
      'item': 'https://asoltu.com/',
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

void _setPageJsonLd(SeoMeta meta) {
  final graph = <Map<String, Object?>>[
    {
      '@type': 'Organization',
      'name': 'ASOLTU Tech Solutions',
      'url': 'https://asoltu.com',
      'logo': 'https://asoltu.com/favicon.png',
      'sameAs': [
        'https://www.linkedin.com/company/asoltu',
        'https://x.com/asoltu',
      ],
      'contactPoint': [
        {
          '@type': 'ContactPoint',
          'contactType': 'sales',
          'email': 'sales@asoltu.com',
          'availableLanguage': ['English', 'Hindi'],
        },
        {
          '@type': 'ContactPoint',
          'contactType': 'customer support',
          'email': 'support@asoltu.com',
          'availableLanguage': ['English', 'Hindi'],
        },
      ],
    },
    {
      '@type': 'SoftwareApplication',
      'name': 'ASOLTU School ERP',
      'applicationCategory': 'BusinessApplication',
      'operatingSystem': 'Web, Android, Desktop',
      'url': 'https://asoltu.com',
      'description': meta.description,
      'offers': {
        '@type': 'Offer',
        'price': '0',
        'priceCurrency': 'INR',
        'description': 'Start Free Demo',
      },
    },
    {
      '@type': 'WebPage',
      'name': meta.fullTitle,
      'description': meta.description,
      'url': meta.canonicalUrl,
      'isPartOf': {
        '@type': 'WebSite',
        'name': 'ASOLTU',
        'url': 'https://asoltu.com',
      },
    },
  ];

  if (meta.path == '/' || meta.path == '/pricing' || meta.path == '/support') {
    graph.add({
      '@type': 'FAQPage',
      'mainEntity': [
        {
          '@type': 'Question',
          'name': 'What is ASOLTU School ERP?',
          'acceptedAnswer': {
            '@type': 'Answer',
            'text':
                'ASOLTU is a cloud school management platform covering admissions, academics, fees, HR, communication, and analytics for modern institutions.',
          },
        },
        {
          '@type': 'Question',
          'name': 'Can we start with a free demo?',
          'acceptedAnswer': {
            '@type': 'Answer',
            'text':
                'Yes. Use Start Free Demo to explore the ERP, or Book Live Demo to schedule a guided walkthrough with our team.',
          },
        },
        {
          '@type': 'Question',
          'name': 'Is our school data secure?',
          'acceptedAnswer': {
            '@type': 'Answer',
            'text':
                'ASOLTU is built with multi-tenant isolation, role-based access control, and enterprise-grade operational safeguards.',
          },
        },
      ],
    });
  }

  if (meta.path == '/blog') {
    graph.add({
      '@type': 'Blog',
      'name': 'ASOLTU Blog',
      'url': 'https://asoltu.com/blog',
      'description': meta.description,
      'publisher': {
        '@type': 'Organization',
        'name': 'ASOLTU Tech Solutions',
        'url': 'https://asoltu.com',
      },
    });
    graph.add({
      '@type': 'Article',
      'headline': 'How modern school ERPs replace spreadsheet chaos',
      'description':
          'A practical look at unifying admissions, fees, attendance, and parent communication on one system of record.',
      'author': {
        '@type': 'Organization',
        'name': 'ASOLTU Tech Solutions',
      },
      'publisher': {
        '@type': 'Organization',
        'name': 'ASOLTU Tech Solutions',
        'logo': {
          '@type': 'ImageObject',
          'url': 'https://asoltu.com/favicon.png',
        },
      },
      'mainEntityOfPage': 'https://asoltu.com/blog',
    });
  }

  _upsertScript('asoltu-page-jsonld', {
    '@context': 'https://schema.org',
    '@graph': graph,
  });
}
