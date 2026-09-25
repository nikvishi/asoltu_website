with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# Make sure MarketingScrollBody is imported
if "import '../../../../core/widgets/layout/marketing_scroll_body.dart';" not in code:
    code = code.replace("import '../../../../core/widgets/layout/site_scaffold.dart';",
                        "import '../../../../core/widgets/layout/site_scaffold.dart';\nimport '../../../../core/widgets/layout/marketing_scroll_body.dart';")

code = code.replace("""    return SiteScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _BentoFeaturesSection(),
            const _CtaSection(),
          ],
        ),
      ),
    );""", """    return SiteScaffold(
      child: MarketingScrollBody(
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
