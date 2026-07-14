// Marketing website Firebase options — same project as ERP, separate app surface.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase options for the ASOLTU marketing website (asoltu.com).
///
/// Uses project `asoltu-school-erp` web app credentials.
/// Only `contacts` and `demo_requests` collections are written by this app.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // Website is Flutter Web–first; reuse web options for tooling/tests.
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAz7U4m0iBMpgi2jBmrT3GQLLQcAUXYmf0',
    appId: '1:474977907871:web:66bddd3ca480cabe1f1eaa',
    messagingSenderId: '474977907871',
    projectId: 'asoltu-school-erp',
    authDomain: 'asoltu-school-erp.firebaseapp.com',
    storageBucket: 'asoltu-school-erp.firebasestorage.app',
  );
}
