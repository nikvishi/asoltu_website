import re

with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# Make sure SiteScaffold is imported
if "import '../../../../core/widgets/layout/site_scaffold.dart';" not in code:
    code = code.replace("import '../../../../core/widgets/layout/max_width_container.dart';",
                        "import '../../../../core/widgets/layout/max_width_container.dart';\nimport '../../../../core/widgets/layout/site_scaffold.dart';")

# Replace Scaffold with SiteScaffold
code = code.replace("""    return Scaffold(
      backgroundColor: context.bgCanvas,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _BentoFeaturesSection(),
            const _CtaSection(),
          ],
        ),
      ),
    );""", """    return SiteScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _BentoFeaturesSection(),
            const _CtaSection(),
          ],
        ),
      ),
    );""")

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
