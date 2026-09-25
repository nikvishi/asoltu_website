with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

# Update BentoCard signature
code = code.replace(
    '  final IconData icon;\n  final double width;\n  final double height;\n  final VoidCallback onTap;\n\n  const _BentoCard({required this.title, required this.description, required this.icon, required this.width, required this.height, required this.onTap});',
    '  final IconData icon;\n  final String? imagePath;\n  final double width;\n  final double height;\n  final VoidCallback onTap;\n\n  const _BentoCard({required this.title, required this.description, required this.icon, this.imagePath, required this.width, required this.height, required this.onTap});'
)

# Update BentoCard UI
bento_ui = """
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: context.isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: context.primaryAccent, size: 28),
            ),
            const Spacer(),
            if (imagePath != null) Expanded(child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(imagePath!, fit: BoxFit.cover)))),
            if (imagePath != null) const SizedBox(height: 16),
            Text(title, style: TextStyle(color: context.textPrimary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: context.textSecondary, fontSize: 16, height: 1.5)),
          ],
        ),
"""
import re
code = re.sub(r'        child: Column\([\s\S]*?\]\,\n        \),', bento_ui, code)

# Update Bento usages
code = code.replace(
    "title: 'DataHop & i2droid',",
    "imagePath: 'assets/images/products/datahop_impressive.jpg',\n                  title: 'DataHop & i2droid',"
)
code = code.replace(
    "title: 'PDF-O Suite',",
    "imagePath: 'assets/images/products/adm_impressive.jpg',\n                  title: 'Download Manager & Utilities',"
)

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)
