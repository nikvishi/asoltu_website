import re

with open('lib/core/widgets/layout/site_header.dart', 'r') as f:
    content = f.read()

# Replace the nav list
old_nav = """const _primaryNav = [
  _NavItem('Products', AppRoutes.products),
  _NavItem('Downloads', AppRoutes.downloads),
  _NavItem('About', AppRoutes.about),
  _NavItem('Contact', AppRoutes.contact),
];"""

new_nav = """const _primaryNav = [
  _NavItem('Products', AppRoutes.products),
  _NavItem('Software', '/software'),
  _NavItem('Education', '/education'),
  _NavItem('Downloads', AppRoutes.downloads),
  _NavItem('About', AppRoutes.about),
];"""

content = content.replace(old_nav, new_nav)

with open('lib/core/widgets/layout/site_header.dart', 'w') as f:
    f.write(content)
