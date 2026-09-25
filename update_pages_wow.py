import re

with open('lib/features/products/presentation/pages.dart', 'r') as f:
    content = f.read()

# ProductsPage
content = content.replace(
    "heroIcon: Icons.apps,",
    "heroIcon: Icons.apps,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_wide_clean_modern_hero_webpage_landing_page_ba.png',"
)

# EducationPage
content = content.replace(
    "heroIcon: Icons.menu_book,",
    "heroIcon: Icons.menu_book,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_professional_brand_identity_ui_marketin.png',"
)

# SoftwarePage
content = content.replace(
    "heroIcon: Icons.desktop_windows,",
    "heroIcon: Icons.desktop_windows,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_wide_clean_corporate_marketing_banner_social.png',"
)

# BusinessPage
content = content.replace(
    "heroIcon: Icons.business,",
    "heroIcon: Icons.business,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_modern_brand_guideline_pattern_showcase.png',"
)

# Remove DataHop wrong images (ob-phone, ob-ipad)
content = content.replace(
    "imageAssets: ['assets/images/products/datahop_1.png', 'assets/images/products/datahop_2.png'],",
    "// Waiting for true datahop screenshots"
)

# Add stunning mockups to School ERP
content = content.replace(
    "heroIcon: Icons.domain,",
    "heroIcon: Icons.domain,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_logo_design_for_asoltu_school_erp_is_cen.png',"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(content)
