import 'package:flutter/material.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/erp_redirect_stub.dart'
    if (dart.library.html) '../../../core/utils/erp_redirect_web.dart'
    as erp_redirect;
import '../../../core/widgets/widgets.dart';

/// Corporate /login route — always sends users to the ERP portal.
///
/// ERP is hosted separately at https://erp.asoltu.com
class LoginRedirectPage extends StatefulWidget {
  const LoginRedirectPage({super.key});

  @override
  State<LoginRedirectPage> createState() => _LoginRedirectPageState();
}

class _LoginRedirectPageState extends State<LoginRedirectPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      erp_redirect.redirectToErp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.backgroundLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandLogo(height: 48),
                const SizedBox(height: 28),
                Text(
                  'Redirecting to ERP…',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'You are leaving the marketing site and opening '
                  '${AppUrls.erpPortal}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                const CircularProgressIndicator(),
                const SizedBox(height: 28),
                AsoltuButton(
                  label: 'Open ERP manually',
                  icon: Icons.open_in_new_rounded,
                  onPressed: erp_redirect.redirectToErp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
