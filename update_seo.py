import re

with open('lib/core/seo/seo_config.dart', 'r') as f:
    content = f.read()

new_seo = """
  static final Map<String, SeoMeta> byPath = {
    AppRoutes.home: defaultMeta,
    AppRoutes.products: const SeoMeta(
      title: 'Products | ASOLTU',
      description: 'Explore the complete suite of ASOLTU software. From enterprise school ERP and competitive exam platforms to powerful desktop utilities.',
      path: AppRoutes.products,
    ),
    AppRoutes.education: const SeoMeta(
      title: 'Education Software | ASOLTU',
      description: 'School management and exam preparation platforms engineered by ASOLTU. Including comprehensive mock tests, AI proctoring, and modern campus ERP.',
      path: AppRoutes.education,
    ),
    AppRoutes.software: const SeoMeta(
      title: 'Desktop & Web Software | ASOLTU',
      description: 'High-performance desktop and web utilities, including DataHop for private P2P transfers and Download Manager powered by a Rust engine.',
      path: AppRoutes.software,
    ),
    AppRoutes.business: const SeoMeta(
      title: 'Business Solutions | ASOLTU',
      description: 'Custom software development, enterprise cloud architectures, and document utilities like PDF-O designed for operational efficiency.',
      path: AppRoutes.business,
    ),
    AppRoutes.examSeries: const SeoMeta(
      title: 'Exam Series | ASOLTU',
      description: 'Premium chapterwise and full mock tests for RPSC, REET, SSC, UPSC, and ICAI, secured with advanced AI proctoring.',
      path: AppRoutes.examSeries,
    ),
    AppRoutes.schoolErp: const SeoMeta(
      title: 'School ERP | ASOLTU',
      description: 'A modern operating system for your campus. Unify admissions, fees, attendance, homework, exams, and AI-driven reporting into one platform.',
      path: AppRoutes.schoolErp,
    ),
    AppRoutes.downloadManager: const SeoMeta(
      title: 'Download Manager | ASOLTU',
      description: 'A powerful, crash-safe download manager powered by a Rust engine with multi-connection segmented downloading capabilities.',
      path: AppRoutes.downloadManager,
    ),
    AppRoutes.dataHop: const SeoMeta(
      title: 'DataHop | ASOLTU',
      description: 'Frictionless, private P2P file transfers directly between devices. No cloud, no limits, no accounts. Works on macOS, Windows, iOS, and Android.',
      path: AppRoutes.dataHop,
    ),
    AppRoutes.asoltuRemote: const SeoMeta(
      title: 'AsoltuRemote | ASOLTU',
      description: 'Control your desktop from anywhere securely. Low-latency remote access, file transfer, and cross-platform clients for Windows, Mac, and iOS.',
      path: AppRoutes.asoltuRemote,
    ),
    AppRoutes.pdfO: const SeoMeta(
      title: 'PDF-O | ASOLTU',
      description: 'Edit, compress, and interact with PDFs using AI. Extract text effortlessly using our powerful OCR scanner.',
      path: AppRoutes.pdfO,
    ),
    AppRoutes.downloads: const SeoMeta(
      title: 'Download Center | ASOLTU',
      description: 'Get the latest binaries and installer packages for ASOLTU software. Download DataHop, AsoltuRemote, Download Manager, and more.',
      path: AppRoutes.downloads,
    ),
    AppRoutes.about: const SeoMeta(
      title: 'About ASOLTU Technologies | Software Development Company India',
      description: 'ASOLTU Technologies is a software engineering company building School ERP, Flutter apps, web portals, cloud and AI solutions.',
      path: AppRoutes.about,
    ),
    AppRoutes.blog: const SeoMeta(
      title: 'Blog | ASOLTU',
      description: 'Articles on software development, education technology, cloud infrastructure, and product design from ASOLTU.',
      path: AppRoutes.blog,
      ogType: 'blog',
    ),
    AppRoutes.contact: const SeoMeta(
      title: 'Contact ASOLTU | Sales & Support',
      description: 'Contact ASOLTU Technologies for product demos, custom software projects, or enterprise solutions. Email info@asoltu.com or call +91-9462133119.',
      path: AppRoutes.contact,
    ),
    AppRoutes.careers: const SeoMeta(
      title: 'Careers at ASOLTU',
      description: 'Join our team. Build high-performance software, cross-platform apps, and meaningful products for education and business.',
      path: AppRoutes.careers,
    ),
    AppRoutes.privacy: const SeoMeta(
      title: 'Privacy Policy | ASOLTU',
      description: 'How ASOLTU Technologies collects, uses and protects personal data.',
      path: AppRoutes.privacy,
    ),
    AppRoutes.terms: const SeoMeta(
      title: 'Terms of Service | ASOLTU',
      description: 'Terms governing use of ASOLTU products and services.',
      path: AppRoutes.terms,
    ),
    AppRoutes.refund: const SeoMeta(
      title: 'Refund Policy | ASOLTU',
      description: 'ASOLTU subscription and software services refund policy.',
      path: AppRoutes.refund,
    ),
    AppRoutes.cookies: const SeoMeta(
      title: 'Cookie Policy | ASOLTU',
      description: 'How ASOLTU uses cookies on asoltu.com for analytics and functionality.',
      path: AppRoutes.cookies,
    ),
    AppRoutes.dataProtection: const SeoMeta(
      title: 'Data Protection | ASOLTU',
      description: 'Security, data retention, and privacy rights across ASOLTU services.',
      path: AppRoutes.dataProtection,
    ),
    AppRoutes.disclaimer: const SeoMeta(
      title: 'Disclaimer | ASOLTU',
      description: 'Important disclaimers for ASOLTU products and websites.',
      path: AppRoutes.disclaimer,
    ),
    AppRoutes.documentation: const SeoMeta(
      title: 'Documentation | ASOLTU',
      description: 'Product documentation and user guides for ASOLTU software.',
      path: AppRoutes.documentation,
    ),
    AppRoutes.support: const SeoMeta(
      title: 'Support | ASOLTU Helpdesk',
      description: 'Get help with ASOLTU products. Find FAQs or contact our technical support team.',
      path: AppRoutes.support,
    ),
    AppRoutes.login: const SeoMeta(
      title: 'Login | ASOLTU',
      description: 'Sign in to ASOLTU portals and connected services.',
      path: AppRoutes.login,
      noIndex: true,
    ),
"""
pattern = r'  static final Map<String, SeoMeta> byPath = \{.*?\n    // SEO landings registered from content registry'
content = re.sub(pattern, new_seo + "    // SEO landings registered from content registry", content, flags=re.DOTALL)

with open('lib/core/seo/seo_config.dart', 'w') as f:
    f.write(content)
