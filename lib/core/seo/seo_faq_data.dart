/// Canonical FAQ content shared by homepage UI + JSON-LD FAQPage schema.
abstract final class SeoFaqData {
  SeoFaqData._();

  /// Primary SEO FAQ set (must match visible FAQ where possible).
  static const List<(String, String)> primary = [
    (
      'What is School ERP?',
      'School ERP (Enterprise Resource Planning) is integrated school management software that connects admissions, academics, attendance, fees, exams, HR, transport and parent communication on one secure platform. ASOLTU School ERP is built for Indian schools including CBSE and RBSE workflows.',
    ),
    (
      'Why choose ASOLTU School ERP?',
      'ASOLTU School ERP combines modern Flutter-based experiences with multi-tenant security, role-based access, offline-ready operations, AI-assisted reports and modules for admins, teachers, parents and students — built by ASOLTU Technologies, a software engineering company in India.',
    ),
    (
      'Is ASOLTU suitable for CBSE schools?',
      'Yes. ASOLTU School ERP supports academic structures, fee schedules, examinations and reporting patterns commonly used by CBSE schools, with configurable sessions and modules.',
    ),
    (
      'Is ASOLTU suitable for RBSE schools?',
      'Yes. ASOLTU is designed for school administration software needs in Rajasthan and across India, including RBSE-aligned academic and operational workflows that schools can configure.',
    ),
    (
      'Can parents use ASOLTU?',
      'Yes. Parents can use dedicated parent experiences for fees, attendance, results, homework and school updates — reducing office queues and improving communication.',
    ),
    (
      'Does ASOLTU support Android?',
      'Yes. ASOLTU supports Android and modern web/desktop experiences so staff and parents can access the student management system from phones and browsers.',
    ),
    (
      'Does ASOLTU work offline?',
      'Critical school operations are designed with offline-friendly workflows so campuses can stay productive during connectivity issues and sync when online.',
    ),
  ];

  /// Extended product FAQs shown on homepage (includes primary + more).
  static const List<(String, String)> homepage = [
    ...primary,
    (
      'Is ASOLTU multi-campus?',
      'Yes. You can manage multiple campuses, branches and education groups from a single secure control plane with proper isolation.',
    ),
    (
      'How do I book a demo?',
      'Use Book Demo on the website, email info@asoltu.com, call +91-9462133119, or message us on WhatsApp to schedule a guided walkthrough.',
    ),
    (
      'Is our school data secure?',
      'ASOLTU is built with multi-tenant isolation, role-based access control, secure authentication and operational safeguards for institutional data. We design with future DPDP readiness in mind.',
    ),
    (
      'Which modules are included?',
      'Admissions, attendance, fees, examinations, homework, library, transport, inventory, HR & payroll, timetable, hostel, biometric, visitor management, analytics, AI reports, parent/teacher/student apps and admin dashboard.',
    ),
    (
      'Does ASOLTU build custom software?',
      'Yes. Beyond School ERP, ASOLTU Technologies builds custom software, Flutter apps, websites, AI solutions and cloud systems for schools and businesses.',
    ),
    (
      'Where do we sign in?',
      'The ERP portal is hosted separately at erp.asoltu.com. Marketing and product information live on asoltu.com.',
    ),
    (
      'How do I contact ASOLTU?',
      'Email info@asoltu.com · Phone +91-9462133119 · Office: ASOLTU Technologies, RMA, Ramganj Mandi, Rajasthan, India · Mon–Sat, 10:00 AM – 7:00 PM IST',
    ),
  ];
}
