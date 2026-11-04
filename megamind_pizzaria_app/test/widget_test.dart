import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homepage/main.dart'; // Adjust package name if your project uses a different name

void main() {
  testWidgets('MegaMind Pizza App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MegaMindPizzaApp());

    // Verify that the app starts up and displays initial home route content/title without errors.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}