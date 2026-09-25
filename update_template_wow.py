import re

with open('lib/features/products/presentation/product_landing_template.dart', 'r') as f:
    content = f.read()

content = content.replace(
    "final bool isSoftware;",
    "final bool isSoftware;\n  final String? heroBackgroundImage;"
)
content = content.replace(
    "this.isSoftware = true,",
    "this.isSoftware = true,\n    this.heroBackgroundImage,"
)

hero_code = """
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        image: heroBackgroundImage != null
            ? DecorationImage(
                image: AssetImage(heroBackgroundImage!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.brandNavy.withOpacity(0.85),
                  BlendMode.srcOver,
                ),
              )
            : null,
        gradient: heroBackgroundImage == null ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandNavy,
            Color(0xFF0F1A42),
            AppColors.brandNavy,
          ],
        ) : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
"""

# replace _buildHero completely up to `child: MaxWidthContainer(`
content = re.sub(
    r'  Widget _buildHero\(BuildContext context\) \{.*?padding: const EdgeInsets\.symmetric\(horizontal: 24, vertical: 80\),',
    hero_code.strip(),
    content,
    flags=re.DOTALL
)

with open('lib/features/products/presentation/product_landing_template.dart', 'w') as f:
    f.write(content)

