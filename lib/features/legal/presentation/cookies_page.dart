import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class CookiesPage extends StatelessWidget {
  const CookiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Cookie Policy',
      sections: [
        (
          '1. What are cookies?',
          'Cookies and similar technologies store small pieces of data on your device to enable site functionality, remember preferences, and understand traffic patterns.'
        ),
        (
          '2. How ASOLTU uses cookies',
          'On asoltu.com we may use essential cookies required for routing and security, preference cookies for UI state, and analytics cookies (when configured) such as Google Analytics 4 to measure page performance and conversions.'
        ),
        (
          '3. Third-party cookies',
          'If Meta Pixel, LinkedIn Insight, or similar tags are enabled, those providers may set their own cookies according to their policies. Integration points exist in our codebase but may be inactive until IDs are configured.'
        ),
        (
          '4. Managing cookies',
          'You can control cookies through your browser settings. Blocking essential cookies may affect site reliability. Analytics opt-outs may be available via browser extensions or OS-level privacy controls.'
        ),
        (
          '5. Updates',
          'We may update this Cookie Policy as our marketing stack evolves. Please review this page periodically.'
        ),
        (
          '6. Contact',
          'Questions: info@asoltu.com'
        ),
      ],
    );
  }
}
