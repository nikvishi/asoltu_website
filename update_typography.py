import re

with open('lib/core/theme/app_typography.dart', 'r') as f:
    code = f.read()

# Replace poppins with plusJakartaSans
code = code.replace("poppinsTextTheme", "plusJakartaSansTextTheme")
code = code.replace("GoogleFonts.poppins", "GoogleFonts.plusJakartaSans")

with open('lib/core/theme/app_typography.dart', 'w') as f:
    f.write(code)

