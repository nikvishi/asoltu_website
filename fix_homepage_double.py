with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

import re

# Remove SiteScaffold and MarketingScrollBody
code = code.replace("""    return SiteScaffold(
      child: MarketingScrollBody(
        child: Column(
          children: [
            const _HeroSection(),
            const _BentoFeaturesSection(),
            const _CtaSection(),
          ],
        ),
      ),
    );""", """    return Column(
      children: [
        const _HeroSection(),
        const _BentoFeaturesSection(),
        const _CtaSection(),
      ],
    );""")

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
