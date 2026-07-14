import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Disclaimer',
      sections: [
        (
          '1. General information',
          'Content on asoltu.com is provided for general informational purposes about ASOLTU Tech Solutions and ASOLTU School ERP. It does not constitute legal, financial, or professional advice for any specific institution.'
        ),
        (
          '2. Product descriptions',
          'Feature descriptions, module lists, roadmaps, sample articles, metrics, and illustrations on the marketing website are intended to help evaluators understand capabilities. Commercial commitments are defined only in written proposals, order forms, or signed agreements.'
        ),
        (
          '3. No warranty on website content',
          'While we strive for accuracy, asoltu.com may contain technical inaccuracies or typographical errors. ASOLTU makes no warranty that website content is complete, current, or free of errors at all times.'
        ),
        (
          '4. External links',
          'The website may link to third-party sites (including maps, social networks, or documentation hosts). ASOLTU is not responsible for third-party content, availability, or practices.'
        ),
        (
          '5. ERP product separate terms',
          'Use of the ASOLTU School ERP product at erp.asoltu.com is governed by separate subscription and service terms. Access via marketing forms does not automatically create an ERP tenancy or commercial contract.'
        ),
        (
          '6. Testimonials & illustrative stories',
          'Customer stories, sample scenarios, and representative metrics on the marketing site may be illustrative of typical use cases. They are not guarantees of results for every institution.'
        ),
        (
          '7. Limitation',
          'To the maximum extent permitted by law, ASOLTU is not liable for decisions made solely based on marketing website content. Always validate requirements with our team for your campus context.'
        ),
        (
          '8. Contact',
          'Questions: support@asoltu.com · Sales: sales@asoltu.com'
        ),
      ],
    );
  }
}
