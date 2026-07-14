import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Privacy Policy',
      sections: [
        (
          '1. Introduction',
          'ASOLTU Tech Solutions (“ASOLTU”, “we”, “us”) operates the marketing website at asoltu.com and school ERP services at erp.asoltu.com. This Privacy Policy explains how we collect, use, and protect personal information submitted through our marketing website, including contact and demo request forms.'
        ),
        (
          '2. Information we collect',
          'We may collect full name, school name, mobile number, email address, city, state, school type, student counts, preferred demo times, and free-text messages when you contact us or book a demo. We also collect standard technical logs such as browser type, pages visited, and approximate location derived from IP address when analytics are enabled.'
        ),
        (
          '3. How we use information',
          'We use submitted information to respond to enquiries, schedule demos, improve our website and products, communicate product updates (with consent where required), and protect our services from abuse. Marketing form data is stored in Firebase Firestore collections reserved for website leads (contacts, demo_requests).'
        ),
        (
          '4. Sharing',
          'We do not sell personal information. We may share data with infrastructure providers (such as Google Firebase/Google Cloud) solely to operate the website and process leads, or when required by law.'
        ),
        (
          '5. Data retention',
          'Lead records are retained as long as needed for sales follow-up, compliance, and legitimate business purposes, then deleted or anonymized.'
        ),
        (
          '6. Security',
          'We apply industry-standard safeguards including transport encryption (HTTPS) and access controls on our cloud project. No method of transmission is 100% secure; please avoid sending sensitive credentials via public forms.'
        ),
        (
          '7. Your rights',
          'Depending on your jurisdiction, you may request access, correction, or deletion of personal data we hold about you. Contact support@asoltu.com for privacy requests.'
        ),
        (
          '8. Children',
          'The marketing website is intended for school administrators and adults evaluating ASOLTU products. It is not directed at children under 13.'
        ),
        (
          '9. Changes',
          'We may update this policy from time to time. Material changes will be reflected by updating the “Last updated” date on this page.'
        ),
        (
          '10. Contact',
          'ASOLTU Tech Solutions — privacy enquiries: support@asoltu.com'
        ),
      ],
    );
  }
}
