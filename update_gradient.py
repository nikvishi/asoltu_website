import re

with open('lib/features/products/presentation/product_landing_template.dart', 'r') as f:
    content = f.read()

# Replace color: AppColors.brandNavy with a gradient
replacement = """
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandNavy,
            Color(0xFF0F1A42), // slightly darker navy
            AppColors.brandNavy,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
"""
content = re.sub(r'    return Container\(\n      color: AppColors\.brandNavy,\n      width: double\.infinity,\n      padding: const EdgeInsets\.symmetric\(horizontal: 24, vertical: 80\),', replacement, content, flags=re.DOTALL)

with open('lib/features/products/presentation/product_landing_template.dart', 'w') as f:
    f.write(content)
