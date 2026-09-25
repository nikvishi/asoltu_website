import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/breakpoints.dart';
import '../../routing/route_names.dart';
import '../../theme/theme_manager.dart';
import '../components/brand_logo.dart';
import 'max_width_container.dart';

const _columns = [
  (
    'Apps',
    [
      ('DataHop', AppRoutes.dataHop),
      ('Download Manager', AppRoutes.downloadManager),
      ('AsoltuRemote', AppRoutes.asoltuRemote),
      ('PDF-O', AppRoutes.pdfO),
      ('i2Droid', AppRoutes.i2droid),
    ],
  ),
  (
    'Company',
    [
      ('Downloads', AppRoutes.downloads),
      ('School ERP', AppRoutes.schoolErp),
      ('About', AppRoutes.about),
      ('Careers', AppRoutes.careers),
      ('Contact', AppRoutes.contact),
    ],
  ),
  (
    'Legal',
    [
      ('Privacy Policy', AppRoutes.privacy),
      ('Terms of Service', AppRoutes.terms),
      ('Refunds', AppRoutes.refund),
      ('Cookies', AppRoutes.cookies),
      ('Disclaimer', AppRoutes.disclaimer),
    ],
  ),
];

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < Breakpoints.tablet;

    // Link labels have an intrinsic minimum width, so a fixed Row of columns
    // forces the whole page wider than a phone viewport. Wrap instead.
    final brand = SizedBox(
      width: isNarrow ? double.infinity : 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BrandLogo(height: 30),
          const SizedBox(height: 18),
          Text(
            'Native desktop and mobile software, built in Rajasthan.',
            style: TextStyle(
              color: context.textSecondary,
              height: 1.6,
              fontSize: 14.5,
            ),
          ),
        ],
      ),
    );

    return Container(
      color: context.bgCanvas,
      child: Column(
        children: [
          Divider(height: 1, color: context.border),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isNarrow ? 48 : 64,
            ),
            child: MaxWidthContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 48,
                    runSpacing: 40,
                    children: [
                      brand,
                      for (final (heading, links) in _columns)
                        SizedBox(
                          width: isNarrow ? 150 : 180,
                          child: _FooterCol(heading: heading, links: links),
                        ),
                    ],
                  ),
                  SizedBox(height: isNarrow ? 40 : 56),
                  Divider(height: 1, color: context.border),
                  const SizedBox(height: 20),
                  Text(
                    '© ${DateTime.now().year} ASOLTU Technologies',
                    style: TextStyle(color: context.textMuted, fontSize: 12.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterCol extends StatelessWidget {
  const _FooterCol({required this.heading, required this.links});

  final String heading;
  final List<(String, String)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: context.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 18),
        for (final l in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: _FooterLink(label: l.$1, route: l.$2),
          ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.route});
  final String label;
  final String route;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _hovered ? context.textPrimary : context.textSecondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
