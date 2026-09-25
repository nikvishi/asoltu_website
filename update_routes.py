import re

# 1. Update route_names.dart
with open('lib/core/routing/route_names.dart', 'r') as f:
    rn = f.read()

rn = rn.replace(
    "static const String pdfO = '/software/pdf-o';",
    "static const String pdfO = '/software/pdf-o';\n  static const String i2droid = '/software/i2droid';\n  static const String asoltuApp = '/education/asoltu-app';"
)

with open('lib/core/routing/route_names.dart', 'w') as f:
    f.write(rn)

# 2. Update app_router.dart
with open('lib/core/routing/app_router.dart', 'r') as f:
    ar = f.read()

ar = ar.replace(
    "GoRoute(path: 'pdf-o', builder: (_, __) => const PdfOPage()),",
    "GoRoute(path: 'pdf-o', builder: (_, __) => const PdfOPage()),\n                GoRoute(path: 'i2droid', builder: (_, __) => const I2DroidPage()),"
)

ar = ar.replace(
    "GoRoute(path: 'exam-series', builder: (_, __) => const ExamSeriesPage()),",
    "GoRoute(path: 'exam-series', builder: (_, __) => const ExamSeriesPage()),\n                GoRoute(path: 'asoltu-app', builder: (_, __) => const AsoltuAppPage()),"
)

with open('lib/core/routing/app_router.dart', 'w') as f:
    f.write(ar)

