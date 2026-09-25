with open('lib/core/widgets/layout/site_header.dart', 'r') as f:
    code = f.read()

code = code.replace("import '../../theme/breakpoints.dart';", "import '../../constants/breakpoints.dart';")
code = code.replace("import '../../../features/home/presentation/widgets/book_demo_dialog.dart';", "import '../components/book_demo_dialog.dart';")

# Add import for route_names.dart if missing
if "route_names.dart" not in code:
    code = code.replace("import '../../routing/app_router.dart';", "import '../../routing/app_router.dart';\nimport '../../routing/route_names.dart';")

with open('lib/core/widgets/layout/site_header.dart', 'w') as f:
    f.write(code)
