import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../components/floating_contact_bar.dart';
import 'site_header.dart';

/// Shared marketing chrome: sticky header + expanded page slot + contact FABs.
///
/// Page content must supply its own scroll + footer via [MarketingScrollBody]
/// (applied in the router page builder).
class SiteScaffold extends StatefulWidget {
  const SiteScaffold({
    super.key,
    required this.child,
    this.showFooter = true,
  });

  final Widget child;
  final bool showFooter;

  @override
  State<SiteScaffold> createState() => _SiteScaffoldState();
}

class _SiteScaffoldState extends State<SiteScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _scrollController,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundLight,
        drawer: const SiteMobileDrawer(),
        floatingActionButton: const FloatingContactBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Semantics(
              container: true,
              header: true,
              label: 'Site header',
              child: SiteHeader(
                onOpenMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
            Expanded(
              child: Semantics(
                container: true,
                label: 'Main content',
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
