import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean URLs on web: https://asoltu.com/pricing (no hash routing).
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // Marketing website Firebase (same project, lead collections only).
  // Skipped gracefully if already initialized (hot restart / tests).
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    debugPrint('Firebase init skipped/failed (forms may log locally): $e');
  }

  runApp(const AsoltuWebsiteApp());
}
