import 'package:flutter/material.dart';

import 'legal_document_page.dart';

class RefundPage extends StatelessWidget {
  const RefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentPage(
      title: 'Refund Policy',
      sections: [
        (
          '1. Scope',
          'This Refund Policy applies to paid ASOLTU School ERP subscriptions and professional services sold by ASOLTU Tech Solutions. Free demos and evaluation access are not billable and therefore not refundable.'
        ),
        (
          '2. Subscription fees',
          'Unless otherwise stated in a signed order form, annual/recurring subscription fees are non-refundable once the billing period starts. Mid-term cancellations stop future renewals but do not automatically generate prorated refunds.'
        ),
        (
          '3. Implementation services',
          'Custom onboarding or migration fees are generally non-refundable after work has begun. If ASOLTU cancels a paid service before delivery, eligible prepaid amounts may be refunded.'
        ),
        (
          '4. Duplicate or erroneous charges',
          'If you were charged in error, contact sales@asoltu.com or support@asoltu.com within 14 days with payment references. Verified duplicate charges will be refunded.'
        ),
        (
          '5. Process',
          'Approved refunds are processed to the original payment method within a commercially reasonable timeframe (typically 7–14 business days depending on the provider).'
        ),
        (
          '6. Contact',
          'Billing questions: sales@asoltu.com'
        ),
      ],
    );
  }
}
