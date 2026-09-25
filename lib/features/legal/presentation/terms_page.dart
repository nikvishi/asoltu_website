import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Terms of Service',
      sections: [
        (
          '1. Agreement',
          'By accessing asoltu.com you agree to these Terms of Service. The ERP product at erp.asoltu.com may be governed by separate subscription agreements.'
        ),
        (
          '2. Use of the website',
          'You may browse public pages and submit enquiries in good faith. You must not misuse forms, attempt unauthorized access, scrape content aggressively, or interfere with site availability.'
        ),
        (
          '3. Product information',
          'Descriptions of ASOLTU features, pricing, and roadmaps on the marketing site are informational. Commercial terms are confirmed in proposals or contracts.'
        ),
        (
          '4. Accounts & ERP access',
          'ERP logins are provided under separate terms. Marketing site forms do not create ERP tenancy automatically.'
        ),
        (
          '5. Intellectual property',
          'ASOLTU branding, UI, copy, and software are owned by ASOLTU Technologies or its licensors. You may not copy or redistribute materials without permission.'
        ),
        (
          '6. Disclaimers',
          'The website is provided “as is” without warranties of uninterrupted availability. We are not liable for indirect or consequential damages arising from website use.'
        ),
        (
          '7. Limitation of liability',
          'To the maximum extent permitted by law, ASOLTU’s total liability related to website use is limited to the amount you paid us for website services (if any) in the prior three months.'
        ),
        (
          '8. Governing law',
          'These terms are governed by the laws of India, without regard to conflict-of-law principles, unless a written enterprise agreement states otherwise.'
        ),
        (
          '9. Contact',
          'Questions: info@asoltu.com'
        ),
      ],
    );
  }
}
