// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

import '../constants/app_urls.dart';

Future<void> redirectToErp() async {
  html.window.location.href = AppUrls.erpPortal;
}
