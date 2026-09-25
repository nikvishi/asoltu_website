import 'package:flutter/material.dart';

import '../../../core/data/products.dart';
import 'product_hub_page.dart';
import 'product_landing_template.dart';
import 'product_page.dart';

// ---------------------------------------------------------------------------
// Downloadable products
//
// Each page is [ProductPage] over the matching entry in
// `core/data/products.dart` — release URLs, versions, sizes, screenshots and
// features all live there, not here.
// ---------------------------------------------------------------------------

/// Renders [id] from the product catalogue, or a not-found page if the id is
/// unknown (which would mean a route and the catalogue drifted apart).
class _CatalogPage extends StatelessWidget {
  const _CatalogPage(this.id);
  final String id;

  @override
  Widget build(BuildContext context) {
    final product = productById(id);
    if (product == null) {
      // Only reachable if a route and the catalogue drift apart.
      return const SizedBox.shrink();
    }
    return ProductPage(product: product);
  }
}

class DownloadManagerPage extends StatelessWidget {
  const DownloadManagerPage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('download-manager');
}

class DataHopPage extends StatelessWidget {
  const DataHopPage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('datahop');
}

class AsoltuRemotePage extends StatelessWidget {
  const AsoltuRemotePage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('asoltu-remote');
}

class PdfOPage extends StatelessWidget {
  const PdfOPage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('pdf-o');
}

class KhataBahiPage extends StatelessWidget {
  const KhataBahiPage({super.key});
  @override
  // Not in the catalogue yet — see kKhataBahiProduct's doc comment.
  Widget build(BuildContext context) =>
      const ProductPage(product: kKhataBahiProduct);
}

class I2DroidPage extends StatelessWidget {
  const I2DroidPage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('i2droid');
}

class AsoltuAppPage extends StatelessWidget {
  const AsoltuAppPage({super.key});
  @override
  Widget build(BuildContext context) => const _CatalogPage('asoltu-app');
}

// ---------------------------------------------------------------------------
// Hubs
// ---------------------------------------------------------------------------

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ProductHubPage(
      eyebrow: 'Products',
      title: 'Everything ASOLTU makes.',
      subtitle:
          'Desktop utilities, mobile apps, and the school platform behind them. '
          'Pick one and download it now.',
      products: kProducts,
      links: const [
        HubLink(
          'School ERP',
          'Admissions, fees, attendance and exams for a whole campus.',
          '/business/school-erp',
          Icons.account_balance_rounded,
        ),
        HubLink(
          'Exam Series',
          'Mock tests and AI proctoring for competitive exams.',
          '/education/exam-series',
          Icons.fact_check_rounded,
        ),
      ],
    );
  }
}

class SoftwarePage extends StatelessWidget {
  const SoftwarePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ProductHubPage(
      eyebrow: 'Desktop & mobile',
      title: 'Apps you install,\nnot tabs you keep open.',
      subtitle:
          'Built with Rust and Flutter so they start fast, stay small, and keep '
          'your files on your own machine.',
      products: kProducts
          .where((p) => p.id != 'asoltu-app')
          .toList(growable: false),
    );
  }
}

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final app = productById('asoltu-app');
    return ProductHubPage(
      eyebrow: 'Education',
      title: 'Software for schools\nand the students in them.',
      subtitle:
          'From running a whole campus to practising for the exam at the end of '
          'it, in one ecosystem.',
      products: app == null ? const [] : [app],
      links: const [
        HubLink(
          'School ERP',
          'Attendance, fees, exams and AI-assisted reports in one platform.',
          '/business/school-erp',
          Icons.account_balance_rounded,
        ),
        HubLink(
          'Exam Series',
          'Chapterwise and full mock tests for RPSC, REET, SSC, UPSC and ICAI.',
          '/education/exam-series',
          Icons.fact_check_rounded,
        ),
      ],
    );
  }
}

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});
  @override
  Widget build(BuildContext context) {
    final picks = kProducts
        .where((p) => p.id == 'pdf-o' || p.id == 'asoltu-remote')
        .toList(growable: false);

    return ProductHubPage(
      eyebrow: 'Business',
      title: 'Software that respects\nhow you already work.',
      subtitle:
          'The campus platform, the document tools around it, and custom builds '
          'when what you need does not exist yet.',
      products: picks,
      links: const [
        HubLink(
          'School ERP',
          'A complete campus management system for modern institutions.',
          '/business/school-erp',
          Icons.school_rounded,
        ),
        HubLink(
          'Talk to us',
          'Custom Flutter apps, cloud infrastructure and integrations.',
          '/contact',
          Icons.forum_rounded,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Education / ERP landings — these are demo-led, not download-led, so they
// keep the marketing template rather than the product template.
// ---------------------------------------------------------------------------

class ExamSeriesPage extends StatelessWidget {
  const ExamSeriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'Exam Series',
      subtitle: 'Premium mock tests and AI proctoring',
      description:
          'Prepare with confidence. Expert study material, chapterwise tests, '
          'and full mock exams for RPSC, RAS, REET, SSC, UPSC and ICAI.',
      heroIcon: Icons.assignment_turned_in_rounded,
      primaryActionLabel: 'Get the app',
      primaryActionUrl: '/education/asoltu-app',
      features: [
        ProductFeature(
          title: 'Extensive coverage',
          description:
              'Targeted material for every major Indian competitive exam.',
          icon: Icons.library_books_rounded,
        ),
        ProductFeature(
          title: 'AI proctoring',
          description:
              'Assessment integrity that institutions can actually rely on.',
          icon: Icons.camera_front_rounded,
        ),
        ProductFeature(
          title: 'Detailed analytics',
          description:
              'Find the weak topics with granular score breakdowns.',
          icon: Icons.analytics_rounded,
        ),
      ],
    );
  }
}

class SchoolErpPage extends StatelessWidget {
  const SchoolErpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductLandingTemplate(
      title: 'School ERP',
      subtitle: 'A modern operating system for your campus',
      description:
          'Move beyond spreadsheets and disjointed tools. ASOLTU School ERP '
          'unifies admissions, fees, attendance, homework, exams and AI-driven '
          'reporting into one platform.',
      heroIcon: Icons.domain_rounded,
      primaryActionLabel: 'Book a demo',
      primaryActionUrl: '/contact',
      secondaryActionLabel: 'Admin login',
      secondaryActionUrl: 'https://erp.asoltu.com',
      imageAssets: [
        'assets/images/products/erp_1.jpg',
        'assets/images/products/erp_2.jpg',
      ],
      features: [
        ProductFeature(
          title: 'Complete lifecycle',
          description:
              'From admissions pipelines to alumni, everything is connected.',
          icon: Icons.all_inclusive_rounded,
        ),
        ProductFeature(
          title: 'AI insights',
          description:
              'Operational summaries and leadership reports, instantly.',
          icon: Icons.auto_graph_rounded,
        ),
        ProductFeature(
          title: 'Multi-role portals',
          description:
              'Dedicated apps for admins, teachers, students and parents.',
          icon: Icons.people_rounded,
        ),
      ],
    );
  }
}
