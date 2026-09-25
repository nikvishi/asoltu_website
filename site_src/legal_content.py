"""Legal page copy, ported verbatim from lib/features/legal/presentation/*.

Kept as data (title -> list of (heading, body)) so build.py can render every
legal page through one template, same as LegalDocumentPage did in Flutter.
"""

LEGAL_PAGES = {
    "privacy": {
        "route": "/privacy",
        "title": "Privacy Policy",
        "sections": [
            ("1. Introduction", "ASOLTU Technologies (“ASOLTU”, “we”, “us”) operates the marketing website at asoltu.com and school ERP services at erp.asoltu.com. This Privacy Policy explains how we collect, use, and protect personal information submitted through our marketing website, including contact and demo request forms."),
            ("2. Information we collect", "We may collect full name, school name, mobile number, email address, city, state, school type, student counts, preferred demo times, and free-text messages when you contact us or book a demo. We also collect standard technical logs such as browser type, pages visited, and approximate location derived from IP address when analytics are enabled."),
            ("3. How we use information", "We use submitted information to respond to enquiries, schedule demos, improve our website and products, communicate product updates (with consent where required), and protect our services from abuse. Marketing form data is stored in Firebase Firestore collections reserved for website leads (contacts, demo_requests)."),
            ("4. Sharing", "We do not sell personal information. We may share data with infrastructure providers (such as Google Firebase/Google Cloud) solely to operate the website and process leads, or when required by law."),
            ("5. Data retention", "Lead records are retained as long as needed for sales follow-up, compliance, and legitimate business purposes, then deleted or anonymized."),
            ("6. Security", "We apply industry-standard safeguards including transport encryption (HTTPS) and access controls on our cloud project. No method of transmission is 100% secure; please avoid sending sensitive credentials via public forms."),
            ("7. Your rights", "Depending on your jurisdiction, you may request access, correction, or deletion of personal data we hold about you. Contact info@asoltu.com for privacy requests."),
            ("8. Children", "The marketing website is intended for school administrators and adults evaluating ASOLTU products. It is not directed at children under 13."),
            ("9. Changes", "We may update this policy from time to time. Material changes will be reflected by updating the “Last updated” date on this page."),
            ("10. Contact", "ASOLTU Technologies — privacy enquiries: info@asoltu.com"),
        ],
    },
    "terms": {
        "route": "/terms",
        "title": "Terms of Service",
        "sections": [
            ("1. Agreement", "By accessing asoltu.com you agree to these Terms of Service. The ERP product at erp.asoltu.com may be governed by separate subscription agreements."),
            ("2. Use of the website", "You may browse public pages and submit enquiries in good faith. You must not misuse forms, attempt unauthorized access, scrape content aggressively, or interfere with site availability."),
            ("3. Product information", "Descriptions of ASOLTU features, pricing, and roadmaps on the marketing site are informational. Commercial terms are confirmed in proposals or contracts."),
            ("4. Accounts & ERP access", "ERP logins are provided under separate terms. Marketing site forms do not create ERP tenancy automatically."),
            ("5. Intellectual property", "ASOLTU branding, UI, copy, and software are owned by ASOLTU Technologies or its licensors. You may not copy or redistribute materials without permission."),
            ("6. Disclaimers", "The website is provided “as is” without warranties of uninterrupted availability. We are not liable for indirect or consequential damages arising from website use."),
            ("7. Limitation of liability", "To the maximum extent permitted by law, ASOLTU’s total liability related to website use is limited to the amount you paid us for website services (if any) in the prior three months."),
            ("8. Governing law", "These terms are governed by the laws of India, without regard to conflict-of-law principles, unless a written enterprise agreement states otherwise."),
            ("9. Contact", "Questions: info@asoltu.com"),
        ],
    },
    "refund": {
        "route": "/refund",
        "title": "Refund Policy",
        "sections": [
            ("1. Scope", "This Refund Policy applies to paid ASOLTU School ERP subscriptions and professional services sold by ASOLTU Technologies. Free demos and evaluation access are not billable and therefore not refundable."),
            ("2. Subscription fees", "Unless otherwise stated in a signed order form, annual/recurring subscription fees are non-refundable once the billing period starts. Mid-term cancellations stop future renewals but do not automatically generate prorated refunds."),
            ("3. Implementation services", "Custom onboarding or migration fees are generally non-refundable after work has begun. If ASOLTU cancels a paid service before delivery, eligible prepaid amounts may be refunded."),
            ("4. Duplicate or erroneous charges", "If you were charged in error, contact info@asoltu.com within 14 days with payment references. Verified duplicate charges will be refunded."),
            ("5. Process", "Approved refunds are processed to the original payment method within a commercially reasonable timeframe (typically 7–14 business days depending on the provider)."),
            ("6. Contact", "Billing questions: info@asoltu.com"),
        ],
    },
    "cookies": {
        "route": "/cookies",
        "title": "Cookie Policy",
        "sections": [
            ("1. What are cookies?", "Cookies and similar technologies store small pieces of data on your device to enable site functionality, remember preferences, and understand traffic patterns."),
            ("2. How ASOLTU uses cookies", "On asoltu.com we may use essential cookies required for routing and security, preference cookies for UI state, and analytics cookies (when configured) such as Google Analytics 4 to measure page performance and conversions."),
            ("3. Third-party cookies", "If Meta Pixel, LinkedIn Insight, or similar tags are enabled, those providers may set their own cookies according to their policies. Integration points exist in our codebase but may be inactive until IDs are configured."),
            ("4. Managing cookies", "You can control cookies through your browser settings. Blocking essential cookies may affect site reliability. Analytics opt-outs may be available via browser extensions or OS-level privacy controls."),
            ("5. Updates", "We may update this Cookie Policy as our marketing stack evolves. Please review this page periodically."),
            ("6. Contact", "Questions: info@asoltu.com"),
        ],
    },
    "data-protection": {
        "route": "/data-protection",
        "title": "Data Protection",
        "sections": [
            ("1. Purpose", "This Data Protection statement explains how ASOLTU Technologies (“ASOLTU”) protects personal and institutional data processed through asoltu.com (marketing) and erp.asoltu.com (product). It complements our Privacy Policy and Terms of Service."),
            ("2. Separation of marketing and product data", "Marketing website leads (contact and demo requests) are stored in dedicated Firestore collections for sales follow-up. ERP tenant data for schools is isolated within multi-tenant product architecture and is not mixed with public marketing form storage. Access patterns for marketing leads and product operations are intentionally separated."),
            ("3. Categories of data", "Marketing: contact details and enquiry content you submit. Product: institution-configured academic, financial, HR, and communication data entered by authorized school users. Technical logs: security and performance telemetry required to operate services."),
            ("4. Lawful use", "We process data to provide contracted services, respond to enquiries, improve reliability and security, meet legal obligations, and communicate product updates where permitted. We do not sell personal data."),
            ("5. Security measures", "ASOLTU applies industry-standard safeguards including HTTPS transport encryption, cloud provider security controls, role-based access concepts for product users, and operational least-privilege practices for internal access. No system is perfectly secure; we continuously improve controls."),
            ("6. Multi-tenant isolation", "ASOLTU School ERP is designed with multi-tenant isolation so institution data boundaries are enforced by architecture and access control. Schools and education groups should configure roles carefully and train staff on least-privilege access."),
            ("7. Subprocessors", "Infrastructure may include Google Firebase / Google Cloud and similar providers necessary to host applications, databases, and messaging. These processors act under contractual and technical controls appropriate to the service."),
            ("8. Retention", "Marketing leads are retained for sales follow-up and compliance needs, then deleted or anonymized. Product tenant data is retained for the life of the subscription and according to customer agreements, backup policies, and legal requirements."),
            ("9. Your rights & requests", "Depending on applicable law, individuals may request access, correction, or deletion of personal data. Institution administrators should raise product data requests through their authorized channels. Privacy and data-protection requests: info@asoltu.com."),
            ("10. Breach notification", "If we become aware of a personal data breach affecting ASOLTU services, we will assess impact and notify affected customers and authorities as required by law and contract, with clear remediation steps where possible."),
            ("11. International considerations", "Services may be hosted on cloud infrastructure that stores or processes data in regions selected for reliability and compliance. Enterprise customers may discuss data residency and contractual terms with sales."),
            ("12. Contact", "ASOLTU Technologies — data protection enquiries: info@asoltu.com · sales enquiries: info@asoltu.com"),
        ],
    },
    "disclaimer": {
        "route": "/disclaimer",
        "title": "Disclaimer",
        "sections": [
            ("1. General information", "Content on asoltu.com is provided for general informational purposes about ASOLTU Technologies and ASOLTU School ERP. It does not constitute legal, financial, or professional advice for any specific institution."),
            ("2. Product descriptions", "Feature descriptions, module lists, roadmaps, sample articles, metrics, and illustrations on the marketing website are intended to help evaluators understand capabilities. Commercial commitments are defined only in written proposals, order forms, or signed agreements."),
            ("3. No warranty on website content", "While we strive for accuracy, asoltu.com may contain technical inaccuracies or typographical errors. ASOLTU makes no warranty that website content is complete, current, or free of errors at all times."),
            ("4. External links", "The website may link to third-party sites (including maps, social networks, or documentation hosts). ASOLTU is not responsible for third-party content, availability, or practices."),
            ("5. ERP product separate terms", "Use of the ASOLTU School ERP product at erp.asoltu.com is governed by separate subscription and service terms. Access via marketing forms does not automatically create an ERP tenancy or commercial contract."),
            ("6. Illustrative content", "UI mockups, sample scenarios and roadmap items on the marketing site illustrate capabilities and direction. They are not guarantees of results for every institution. Commercial commitments are defined only in written agreements."),
            ("7. Limitation", "To the maximum extent permitted by law, ASOLTU is not liable for decisions made solely based on marketing website content. Always validate requirements with our team for your campus context."),
            ("8. Contact", "Questions: info@asoltu.com · Phone: +91-9462133119 · Office: ASOLTU Technologies, RMA, Ramganj Mandi, Rajasthan, India"),
        ],
    },
}
