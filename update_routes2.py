import re

with open('lib/core/routing/route_names.dart', 'r') as f:
    rn = f.read()

if "datahop" not in rn:
    rn = rn.replace(
        "static const String i2droid = '/software/i2droid';",
        "static const String i2droid = '/software/i2droid';\n  static const String datahop = '/software/datahop';\n  static const String downloadManager = '/software/download-manager';"
    )
    with open('lib/core/routing/route_names.dart', 'w') as f:
        f.write(rn)

with open('lib/core/routing/app_router.dart', 'r') as f:
    ar = f.read()

if "DataHopPage" not in ar:
    ar = ar.replace(
        "GoRoute(path: 'i2droid', builder: (_, __) => const I2DroidPage()),",
        "GoRoute(path: 'i2droid', builder: (_, __) => const I2DroidPage()),\n                GoRoute(path: 'datahop', builder: (_, __) => const DataHopPage()),\n                GoRoute(path: 'download-manager', builder: (_, __) => const DownloadManagerPage()),"
    )
    with open('lib/core/routing/app_router.dart', 'w') as f:
        f.write(ar)

