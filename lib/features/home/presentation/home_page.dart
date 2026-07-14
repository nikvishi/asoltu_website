import 'package:flutter/material.dart';

import 'widgets/faq_section.dart';
import 'widgets/features_section.dart';
import 'widgets/final_cta_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/pricing_section.dart';
import 'widgets/screenshots_section.dart';
import 'widgets/statistics_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/trust_section.dart';
import 'widgets/why_asoltu_section.dart';

/// Final production homepage (Phase 4.5).
/// Footer is provided by [SiteScaffold].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Semantic landmark for accessibility / screen readers.
    return Semantics(
      container: true,
      label: 'ASOLTU homepage',
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeroSection(),
          TrustSection(),
          FeaturesSection(),
          WhyAsoltuSection(),
          ScreenshotsSection(),
          StatisticsSection(),
          TestimonialsSection(),
          PricingSection(),
          FaqSection(),
          FinalCtaSection(),
        ],
      ),
    );
  }
}
