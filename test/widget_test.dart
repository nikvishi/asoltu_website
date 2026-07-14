import 'package:asoltu_website/app.dart';
import 'package:asoltu_website/core/routing/app_router.dart';
import 'package:asoltu_website/core/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Homepage boots with marketing shell', (tester) async {
    await tester.pumpWidget(const AsoltuWebsiteApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('ASOLTU'), findsWidgets);
    expect(find.text('Start Free Demo'), findsWidgets);
  });

  testWidgets('Primary routes resolve without crash', (tester) async {
    // Tall desktop surface so long marketing pages do not hit test-viewport overflows.
    tester.view.physicalSize = const Size(1440, 5000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AsoltuWebsiteApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    for (final path in [
      AppRoutes.products,
      AppRoutes.solutions,
      AppRoutes.pricing,
      AppRoutes.about,
      AppRoutes.resources,
      AppRoutes.blog,
      AppRoutes.contact,
      AppRoutes.careers,
      AppRoutes.support,
      AppRoutes.documentation,
      AppRoutes.privacy,
      AppRoutes.disclaimer,
    ]) {
      appRouter.go(path);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      expect(find.byType(MaterialApp), findsOneWidget, reason: 'Route $path');
    }
  });
}
