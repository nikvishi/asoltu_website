// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

import '../data/products.dart';

/// Best-effort OS detection from the browser user agent, so the hero can offer
/// the visitor the build they can actually run.
///
/// Returns null when we cannot tell — callers must show all platforms then.
Platform? detectHostPlatform() {
  final ua = html.window.navigator.userAgent.toLowerCase();

  // iPadOS reports a desktop Mac user agent, so use touch points to tell them
  // apart: a real Mac reports 0.
  final touchPoints = html.window.navigator.maxTouchPoints ?? 0;
  if (ua.contains('iphone') ||
      ua.contains('ipad') ||
      (ua.contains('mac') && touchPoints > 1)) {
    return Platform.appStore;
  }
  if (ua.contains('android')) return Platform.playStore;
  if (ua.contains('win')) return Platform.windows;
  if (ua.contains('mac')) return Platform.macOS;
  return null;
}
