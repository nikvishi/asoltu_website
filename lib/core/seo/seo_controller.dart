import 'package:flutter/services.dart';

import 'seo_config.dart';
import 'seo_controller_stub.dart'
    if (dart.library.html) 'seo_controller_web.dart' as impl;

/// Updates document title and meta tags (web) + task switcher label.
abstract final class SeoController {
  SeoController._();

  static void apply(SeoMeta meta) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: meta.fullTitle,
        primaryColor: 0xFF0D1B5E,
      ),
    );
    impl.applySeo(meta);
  }
}
