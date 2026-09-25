import re

with open('lib/features/products/presentation/pages.dart', 'r') as f:
    content = f.read()

# Add images to DataHop
content = content.replace(
    "// Waiting for true datahop screenshots",
    "imageAssets: ['assets/images/products/datahop_1.jpg'],"
)

# Add images to Download Manager
content = content.replace(
    "heroIcon: Icons.download_for_offline,",
    "heroIcon: Icons.download_for_offline,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_modern_ui_design_mockup_dashboard_backg.png',\n      imageAssets: ['assets/images/brand_mockups/a_clean_modern_ui_design_mockup_dashboard_backg.png'],"
)

# Add images to AsoltuRemote
content = content.replace(
    "heroIcon: Icons.desktop_access_disabled,",
    "heroIcon: Icons.desktop_access_disabled,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_high_resolution_app_icon_logo_design_on.png',\n      imageAssets: ['assets/images/products/remote_1.png', 'assets/images/products/remote_2.png', 'assets/images/products/remote_3.png'],"
)

# Exam Series
content = content.replace(
    "heroIcon: Icons.assignment_turned_in,",
    "heroIcon: Icons.assignment_turned_in,\n      heroBackgroundImage: 'assets/images/brand_mockups/a_clean_professional_brand_identity_ui_marketin.png',"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(content)
