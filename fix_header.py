with open('lib/core/widgets/layout/site_header.dart', 'r') as f:
    code = f.read()

# Replace Positioned with SafeArea/Padding
code = code.replace('''    return Positioned(
      top: 16,
      left: 0,
      right: 0,
      child: Center(''', '''    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Center(''')
        
# Add two closing parenthesis at the end of the return statement
code = code.replace('''            ),
          ),
        ),
      ),
    );
  }
}''', '''            ),
          ),
        ),
      ),
    );
  }
}''') 
# wait, the replace logic for closing brackets is error-prone. Let's just use re.

import re
code = re.sub(r'    return Positioned\([\s\S]*?child: Center\(', '''    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Center(''', code)

with open('lib/core/widgets/layout/site_header.dart', 'w') as f:
    f.write(code)

with open('lib/core/widgets/layout/site_scaffold.dart', 'r') as f:
    scaffold = f.read()

scaffold = scaffold.replace('''        body: Stack(
          children: [
            Positioned.fill(
              child: Semantics(
                container: true,
                label: 'Main content',
                child: widget.child,
              ),
            ),
            Semantics(
              container: true,
              header: true,
              label: 'Site header',
              child: SiteHeader(
                onOpenMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ],
        ),''', '''        body: Column(
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
        ),''')
        
with open('lib/core/widgets/layout/site_scaffold.dart', 'w') as f:
    f.write(scaffold)

