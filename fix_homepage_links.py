import re

with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# Update Play Store link
code = code.replace(
    'https://play.google.com/store/apps/details?id=com.asoltu.learning',
    'https://play.google.com/store/apps/details?id=com.absolutetutorials.app'
)

# Update App Store link
code = code.replace(
    'https://apps.apple.com/us/app/asoltu-tutorials/id6449000000',
    'https://apps.apple.com/in/app/asoltu/id6796294470'
)

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
