import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class DataProtectionPage extends StatelessWidget {
  const DataProtectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Data Protection',
      sections: [
        (
          '1. Purpose',
          'This Data Protection statement explains how ASOLTU Tech Solutions (“ASOLTU”) protects personal and institutional data processed through asoltu.com (marketing) and erp.asoltu.com (product). It complements our Privacy Policy and Terms of Service.'
        ),
        (
          '2. Separation of marketing and product data',
          'Marketing website leads (contact and demo requests) are stored in dedicated Firestore collections for sales follow-up. ERP tenant data for schools is isolated within multi-tenant product architecture and is not mixed with public marketing form storage. Access patterns for marketing leads and product operations are intentionally separated.'
        ),
        (
          '3. Categories of data',
          'Marketing: contact details and enquiry content you submit. Product: institution-configured academic, financial, HR, and communication data entered by authorized school users. Technical logs: security and performance telemetry required to operate services.'
        ),
        (
          '4. Lawful use',
          'We process data to provide contracted services, respond to enquiries, improve reliability and security, meet legal obligations, and communicate product updates where permitted. We do not sell personal data.'
        ),
        (
          '5. Security measures',
          'ASOLTU applies industry-standard safeguards including HTTPS transport encryption, cloud provider security controls, role-based access concepts for product users, and operational least-privilege practices for internal access. No system is perfectly secure; we continuously improve controls.'
        ),
        (
          '6. Multi-tenant isolation',
          'ASOLTU School ERP is designed with multi-tenant isolation so institution data boundaries are enforced by architecture and access control. Schools and education groups should configure roles carefully and train staff on least-privilege access.'
        ),
        (
          '7. Subprocessors',
          'Infrastructure may include Google Firebase / Google Cloud and similar providers necessary to host applications, databases, and messaging. These processors act under contractual and technical controls appropriate to the service.'
        ),
        (
          '8. Retention',
          'Marketing leads are retained for sales follow-up and compliance needs, then deleted or anonymized. Product tenant data is retained for the life of the subscription and according to customer agreements, backup policies, and legal requirements.'
        ),
        (
          '9. Your rights & requests',
          'Depending on applicable law, individuals may request access, correction, or deletion of personal data. Institution administrators should raise product data requests through their authorized channels. Privacy and data-protection requests: support@asoltu.com.'
        ),
        (
          '10. Breach notification',
          'If we become aware of a personal data breach affecting ASOLTU services, we will assess impact and notify affected customers and authorities as required by law and contract, with clear remediation steps where possible.'
        ),
        (
          '11. International considerations',
          'Services may be hosted on cloud infrastructure that stores or processes data in regions selected for reliability and compliance. Enterprise customers may discuss data residency and contractual terms with sales.'
        ),
        (
          '12. Contact',
          'ASOLTU Tech Solutions — data protection enquiries: support@asoltu.com · sales enquiries: sales@asoltu.com'
        ),
      ],
    );
  }
}
