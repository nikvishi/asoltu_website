with open('lib/features/products/presentation/pages.dart', 'r') as f:
    code = f.read()

code = code.replace(
    "'assets/images/products/asoltu_app_1.png'",
    "'assets/images/products/asoltu_app_1.jpg', 'assets/images/products/asoltu_app_2.jpg', 'assets/images/products/asoltu_app_3.jpg', 'assets/images/products/asoltu_app_4.jpg'"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(code)
