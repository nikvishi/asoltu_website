import re

with open('lib/features/products/presentation/product_landing_template.dart', 'r') as f:
    content = f.read()

# Add url to ProductFeature
content = content.replace(
    "class ProductFeature {\n  final String title;\n  final String description;\n  final IconData icon;\n  const ProductFeature({required this.title, required this.description, required this.icon});",
    "class ProductFeature {\n  final String title;\n  final String description;\n  final IconData icon;\n  final String? url;\n  const ProductFeature({required this.title, required this.description, required this.icon, this.url});"
)

# Update _buildFeatureCard to include a link if url is provided
feature_card_replacement = """
  Widget _buildFeatureCard(BuildContext context, ProductFeature feature) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, size: 32, color: AppColors.accentBlue),
          ),
          const SizedBox(height: 24),
          Text(
            feature.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            feature.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          if (feature.url != null) ...[
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                if (feature.url!.startsWith('http')) {
                  launchUrl(Uri.parse(feature.url!));
                } else {
                  // In flutter web go_router, we can just use go router
                  // but we don't have context.go here, we have to import go_router
                  // For now, url_launcher works for relative paths on web if we prepend with # or just use launchUrl. 
                  // Wait, url_launcher might open a new tab. Let's import go_router
                  // Actually, let's just use url_launcher with webOnlyWindowName: '_self'
                }
              },
              // Actually we should import go_router to the template!
            ),
          ]
        ],
      ),
    );
  }
"""

with open('lib/features/products/presentation/product_landing_template.dart', 'w') as f:
    f.write(content)
