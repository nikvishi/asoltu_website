/// SEO landing page content registry — truthful module/service pages.
class LandingPageData {
  const LandingPageData({
    required this.path,
    required this.slug,
    required this.category,
    required this.title,
    required this.metaTitle,
    required this.metaDescription,
    required this.headline,
    required this.subheadline,
    required this.bullets,
    required this.faqs,
  });

  final String path;
  final String slug;
  final String category;
  final String title;
  final String metaTitle;
  final String metaDescription;
  final String headline;
  final String subheadline;
  final List<String> bullets;
  final List<(String, String)> faqs;
}

abstract final class LandingContent {
  LandingContent._();

  static final List<LandingPageData> all = [
    // —— Products / modules ——
    _m(
      'school-erp',
      'School ERP',
      'School ERP Software India | ASOLTU',
      'ASOLTU School ERP — school management software for admissions, attendance, fees, exams, HR and parent apps. Built for Indian schools.',
      'School ERP for modern Indian campuses',
      'One intelligent platform for academics, finance, people and parent communication — engineered with Flutter and cloud technologies.',
      [
        'Admissions through analytics in one system of record',
        'Role-based access for admins, teachers, parents and students',
        'Cloud-hosted multi-tenant foundations',
        'Designed for CBSE and RBSE operational patterns',
      ],
    ),
    _m(
      'attendance-management',
      'Attendance Management',
      'Attendance Management Software for Schools | ASOLTU',
      'School attendance management for students and staff with history, reports and parent alerts — part of ASOLTU School ERP.',
      'Attendance that campuses can trust',
      'Daily marking, historical visibility and parent communication without spreadsheet chaos.',
      [
        'Fast student and staff attendance marking',
        'History and reports for principals and admins',
        'Parent-facing attendance visibility',
        'Supports operational discipline across classes',
      ],
    ),
    _m(
      'student-information-system',
      'Student Information System',
      'Student Information System (SIS) | ASOLTU School ERP',
      'Student information system for records, classes, academics and lifecycle data — modular school management software from ASOLTU.',
      'Student information in one place',
      'Keep student records, class structure and academic lifecycle data connected for every role that needs them.',
      [
        'Central student profiles and academic records',
        'Class and session structure support',
        'Shared truth for fees, attendance and exams',
        'Role-aware access for staff and parents',
      ],
    ),
    _m(
      'fee-management',
      'Fee Management',
      'School Fee Management Software | ASOLTU',
      'School fee management for structures, invoices, receipts, dues and reminders — ASOLTU School ERP finance module.',
      'Fee management with operational clarity',
      'Structure fee plans, collect with discipline and keep families informed with transparent status.',
      [
        'Flexible fee structures and invoices',
        'Receipts and dues tracking',
        'Reminder-friendly collection workflows',
        'Leadership-ready collection visibility',
      ],
    ),
    _m(
      'payroll',
      'Payroll',
      'School Payroll Software | ASOLTU',
      'Payroll for education institutions — salary workflows aligned with HR records in ASOLTU School ERP.',
      'Payroll for education employers',
      'Connect people data and payout workflows so finance and HR stay aligned.',
      [
        'Salary processing workflows',
        'Aligned with staff HR records',
        'Clear operational payout tracking',
        'Built for campus staff structures',
      ],
    ),
    _m(
      'transport-management',
      'Transport Management',
      'School Transport Management Software | ASOLTU',
      'School transport management for routes, vehicles and passenger operations linked to student records.',
      'Transport operations connected to campus data',
      'Manage routes and vehicles without a separate disconnected spreadsheet stack.',
      [
        'Route and vehicle records',
        'Passenger linking to students',
        'Operational tracking for transport desks',
        'Integrated with core school ERP identity',
      ],
    ),
    _m(
      'library-management',
      'Library Management',
      'School Library Management Software | ASOLTU',
      'Library management for catalog, issue/return and overdue tracking — connected to student identity in ASOLTU School ERP.',
      'Library workflows that stay organized',
      'Catalog, issue, return and overdue visibility for campus libraries.',
      [
        'Catalog management',
        'Issue and return workflows',
        'Overdue tracking',
        'Student-linked library activity',
      ],
    ),
    _m(
      'inventory-management',
      'Inventory Management',
      'School Inventory Management | ASOLTU',
      'Campus inventory management for school assets and stock visibility — ASOLTU School ERP inventory module.',
      'Inventory visibility for campus operations',
      'Track institutional inventory with clearer ownership and operational visibility.',
      [
        'Stock and inventory records',
        'Operational campus visibility',
        'Less spreadsheet sprawl for assets',
        'Connected to school administration software',
      ],
    ),
    _m(
      'parent-app',
      'Parent App',
      'School Parent App | ASOLTU',
      'Parent app for fees, attendance, results, homework and school updates — Flutter-powered ASOLTU School ERP experience.',
      'Parent transparency that reduces office load',
      'Give families timely, accurate campus information from a dedicated parent experience.',
      [
        'Fee status and receipt visibility',
        'Attendance and academic updates',
        'Homework and notices',
        'Mobile-friendly Flutter experience',
      ],
    ),
    _m(
      'teacher-app',
      'Teacher App',
      'Teacher App for Schools | ASOLTU',
      'Teacher app for attendance, homework, results and class communication — ASOLTU School ERP classroom tools.',
      'Classroom tools teachers can use daily',
      'Attendance, homework, results and class updates in one teacher-facing experience.',
      [
        'Fast attendance marking',
        'Homework and submissions',
        'Results entry support',
        'Class announcements',
      ],
    ),
    _m(
      'exam-management',
      'Exam Management',
      'Exam Management Software for Schools | ASOLTU',
      'Examination management for assessments, marks, results and report cards — ASOLTU School ERP exams module.',
      'Exam cycles without spreadsheet risk',
      'Run assessments and publish results with clearer ownership and fewer entry errors.',
      [
        'Assessment setup',
        'Marks workflows',
        'Results publication',
        'Report-card ready outputs',
      ],
    ),
    _m(
      'homework-management',
      'Homework Management',
      'Homework Management Software | ASOLTU',
      'Homework management for assignments, submissions and follow-ups with parent visibility — ASOLTU School ERP.',
      'Homework that stays visible',
      'Assignments, submissions and classroom follow-ups shared with the right stakeholders.',
      [
        'Assignment creation',
        'Submission tracking',
        'Teacher follow-ups',
        'Parent visibility options',
      ],
    ),
    _m(
      'ai-reports',
      'AI Reports',
      'AI Reports for Schools | ASOLTU',
      'AI-assisted reports and operational insights for school leaders — decision-ready summaries in ASOLTU School ERP.',
      'AI reports principals can use',
      'Move beyond decorative dashboards toward leadership-friendly summaries of live operations.',
      [
        'Operational summaries',
        'Leadership-oriented insights',
        'Less manual report writing',
        'Grounded in campus module data',
      ],
    ),
    // —— Services ——
    _s(
      'custom-software-development',
      'Custom Software Development',
      'Custom Software Development Company India | ASOLTU',
      'Custom software development for schools and businesses — Flutter, cloud, AI and enterprise systems from ASOLTU Technologies.',
      'Custom software built for real operations',
      'From discovery to deployment — software engineered around your workflows, not generic templates.',
      [
        'Requirements discovery and architecture',
        'Flutter, web and cloud engineering',
        'Secure multi-role product design',
        'Deployment and ongoing support',
      ],
    ),
    _s(
      'flutter-development',
      'Flutter Development',
      'Flutter App Development Company | ASOLTU',
      'Flutter development for web, Android and iOS — cross-platform apps and portals from ASOLTU Technologies.',
      'Flutter expertise for product teams',
      'One modern codebase for polished mobile and web experiences that share a common product truth.',
      [
        'Flutter Web, Android and iOS',
        'Design systems and Material craft',
        'Performance-minded shipping',
        'Ideal for ERP portals and stakeholder apps',
      ],
    ),
    _s(
      'website-development',
      'Website Development',
      'Website Development Company | ASOLTU',
      'Website development for modern brands — responsive, SEO-aware and conversion-focused sites from ASOLTU Technologies.',
      'Websites that look premium and convert',
      'Responsive marketing sites and portals engineered for performance, accessibility and clarity.',
      [
        'Modern responsive UI',
        'SEO-aware structure',
        'Lead capture and CTAs',
        'Cloud-ready deployment',
      ],
    ),
    _s(
      'ai-development',
      'AI Development',
      'AI Development Services | ASOLTU',
      'AI development for education and business automation — intelligent reports, insights and workflow assistance from ASOLTU.',
      'Practical AI for real workflows',
      'AI solutions focused on decision support and automation — not hype demos.',
      [
        'AI-assisted reporting',
        'Operational insight design',
        'Education-context use cases',
        'Integration with existing product data',
      ],
    ),
    _s(
      'cloud-solutions',
      'Cloud Solutions',
      'Cloud Solutions Company India | ASOLTU',
      'Cloud solutions with Firebase and Google Cloud — secure hosting, storage, messaging and scalable architecture from ASOLTU.',
      'Cloud foundations for scalable products',
      'Deploy and operate software on secure cloud infrastructure designed for growth.',
      [
        'Firebase and Google Cloud',
        'Cloud storage and messaging',
        'Scalable multi-tenant patterns',
        'Operational backups and security practices',
      ],
    ),
    _s(
      'software-development-company',
      'Software Development Company',
      'Software Development Company India | ASOLTU Technologies',
      'ASOLTU Technologies is a software development company in India building School ERP, Flutter apps, websites, AI and cloud software for schools and businesses.',
      'A modern software engineering company',
      'Building intelligent software for schools and businesses — with School ERP as our flagship product.',
      [
        'Product engineering mindset',
        'Flutter + cloud stack',
        'Education and business solutions',
        'Based in Rajasthan, serving India',
      ],
    ),
    _s(
      'mobile-app-development-company',
      'Mobile App Development Company',
      'Mobile App Development Company India | ASOLTU',
      'Mobile app development company for Android and iOS — Flutter apps for parents, teachers, students and business teams from ASOLTU.',
      'Mobile apps that stakeholders actually use',
      'Cross-platform mobile experiences connected to secure cloud backends and real operational data.',
      [
        'Android and iOS with Flutter',
        'Role-based stakeholder apps',
        'Cloud-connected backends',
        'UX focused on daily adoption',
      ],
    ),
  ];

  static LandingPageData? byPath(String path) {
    for (final p in all) {
      if (p.path == path) return p;
    }
    return null;
  }

  static List<String> get paths => all.map((e) => e.path).toList();

  static LandingPageData _m(
    String slug,
    String title,
    String metaTitle,
    String metaDescription,
    String headline,
    String subheadline,
    List<String> bullets,
  ) {
    return LandingPageData(
      path: '/modules/$slug',
      slug: slug,
      category: 'Module',
      title: title,
      metaTitle: metaTitle,
      metaDescription: metaDescription,
      headline: headline,
      subheadline: subheadline,
      bullets: bullets,
      faqs: [
        (
          'What is $title in ASOLTU?',
          '$title is part of ASOLTU School ERP / product suite — designed to work with other campus modules rather than as a disconnected tool.',
        ),
        (
          'How do I evaluate $title?',
          'Book a demo via asoltu.com or email info@asoltu.com. We walk through real workflows for your institution type.',
        ),
        (
          'Is this available as a standalone product?',
          'Modules are designed as part of the connected School ERP platform. Talk to us about rollout priority for your campus.',
        ),
      ],
    );
  }

  static LandingPageData _s(
    String slug,
    String title,
    String metaTitle,
    String metaDescription,
    String headline,
    String subheadline,
    List<String> bullets,
  ) {
    return LandingPageData(
      path: '/services/$slug',
      slug: slug,
      category: 'Service',
      title: title,
      metaTitle: metaTitle,
      metaDescription: metaDescription,
      headline: headline,
      subheadline: subheadline,
      bullets: bullets,
      faqs: [
        (
          'What does ASOLTU offer for $title?',
          'ASOLTU Technologies provides $title as part of our software engineering services for schools and businesses — with transparent discovery and delivery.',
        ),
        (
          'How do we start?',
          'Contact info@asoltu.com or call +91-9462133119. Share your goals and we will propose a clear next step.',
        ),
        (
          'Do you only build School ERP?',
          'School ERP is our flagship product. We also build custom software, Flutter apps, websites, AI solutions and cloud systems.',
        ),
      ],
    );
  }
}
