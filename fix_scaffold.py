with open('lib/core/widgets/layout/site_scaffold.dart', 'r') as f:
    code = f.read()

import re

# We need to import site_footer if it's not imported
if "site_footer.dart" not in code:
    code = code.replace("import 'site_header.dart';", "import 'site_header.dart';\nimport 'site_footer.dart';")


new_body = """        body: Column(
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
            if (widget.showFooter) const SiteFooter(),
          ],
        ),"""

# But wait, widget.child is usually a SingleChildScrollView. If it's expanded, the SingleChildScrollView takes the rest of the space, and the footer would always stick to the bottom of the screen instead of being scrollable with the page content!
# This is a common Flutter layout bug for websites. The footer should scroll with the page, NOT stick to the bottom of the viewport unless the page is short.
# But wait, SiteScaffold wraps the ENTIRE thing in a Column.
# If I just stick `SiteFooter()` inside the `Column` at the end, it will be a STICKY footer at the bottom of the viewport.
# If I want it to scroll, it must be INSIDE the SingleChildScrollView of the child. But SiteScaffold doesn't control the scroll view!
