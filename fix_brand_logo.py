import re

with open('lib/core/widgets/components/brand_logo.dart', 'r') as f:
    code = f.read()

# Replace textColor logic
code = code.replace(
    'final textColor = onNavy ? Colors.white : AppColors.brandNavy;',
    'final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.brandNavy;'
)

with open('lib/core/widgets/components/brand_logo.dart', 'w') as f:
    f.write(code)
