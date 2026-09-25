import 'package:flutter/material.dart';

import '../../theme/theme_manager.dart';
import '../components/floating_contact_bar.dart';
import 'site_header.dart';

class SiteScaffold extends StatefulWidget {
  const SiteScaffold({super.key, required this.child, this.showFooter = true});

  final Widget child;
  final bool showFooter;

  @override
  State<SiteScaffold> createState() => _SiteScaffoldState();
}

class _SiteScaffoldState extends State<SiteScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  /// Drives the header's background. A ValueNotifier rather than setState:
  /// setState here rebuilt the entire page on every scroll frame, which was
  /// the main source of scroll jank.
  final ValueNotifier<bool> _scrolled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _scrolled.value = _scrollController.offset > 12;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _scrolled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _scrollController,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.bgCanvas,
        drawer: const SiteMobileDrawer(),
        floatingActionButton: const FloatingContactBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            Positioned.fill(
              child: Semantics(
                container: true,
                label: 'Main content',
                child: widget.child,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // Isolated so the header's own repaints never dirty the page
              // behind it.
              child: RepaintBoundary(
                child: Semantics(
                  container: true,
                  header: true,
                  label: 'Site header',
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _scrolled,
                    builder: (context, scrolled, _) => SiteHeader(
                      scrolled: scrolled,
                      onOpenMenu: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
