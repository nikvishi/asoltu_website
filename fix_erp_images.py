with open('lib/features/products/presentation/pages.dart', 'r') as f:
    code = f.read()

code = code.replace(
    "'assets/images/products/erp_1.png', 'assets/images/products/erp_2.png', 'assets/images/products/erp_3.png'",
    "'assets/images/products/erp_1.jpg', 'assets/images/products/erp_2.jpg'"
)

with open('lib/features/products/presentation/pages.dart', 'w') as f:
    f.write(code)
