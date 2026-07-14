import 'package:url_launcher/url_launcher.dart';

import '../constants/app_urls.dart';

Future<void> redirectToErp() async {
  final uri = Uri.parse(AppUrls.erpPortal);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
