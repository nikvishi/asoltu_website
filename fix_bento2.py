import re

with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# Fix undefined named parameter imagePath
code = re.sub(r"imagePath:\s*'assets/images/products/datahop_impressive.jpg',\n\s*", "", code)
code = re.sub(r"imagePath:\s*'assets/images/products/adm_impressive.jpg',\n\s*", "", code)

# Ensure customVisual is used in _BentoCard if it's not (wait, I passed customVisual, but it might be unused)
# Ah, I replaced _BentoCard but maybe my regex failed there too?
