import re

with open('lib/features/products/presentation/pages.dart', 'r') as f:
    content = f.read()

# Add images to PdfOPage
content = content.replace(
    "primaryActionUrl: null,",
    "primaryActionUrl: null,\n      imageAssets: ['assets/images/products/pdfo_1.png', 'assets/images/products/pdfo_2.png'],"
)

# Add images to DataHopPage
content = content.replace(
    "downloads: [",
    "imageAssets: ['assets/images/products/datahop_1.png', 'assets/images/products/datahop_2.png'],\n      downloads: ["
)

# Add images to SchoolErpPage
content = content.replace(
    "secondaryActionUrl: 'https://erp.asoltu.com',",
    "secondaryActionUrl: 'https://erp.asoltu.com',\n      imageAssets: ['assets/images/products/erp_1.png', 'assets/images/products/erp_2.png', 'assets/images/products/erp_3.png'],"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(content)
