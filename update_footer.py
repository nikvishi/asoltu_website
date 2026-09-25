import re

with open('lib/core/widgets/layout/site_footer.dart', 'r') as f:
    content = f.read()

# Replace links in the footer
content = content.replace("('School ERP', AppRoutes.products),", "('School ERP', '/business/school-erp'),\n                    ('DataHop', '/software/datahop'),\n                    ('Download Manager', '/software/download-manager'),")
content = content.replace("('School ERP', AppRoutes.products),", "('School ERP', '/business/school-erp'),\n                          ('DataHop', '/software/datahop'),\n                          ('Download Manager', '/software/download-manager'),")

with open('lib/core/widgets/layout/site_footer.dart', 'w') as f:
    f.write(content)
