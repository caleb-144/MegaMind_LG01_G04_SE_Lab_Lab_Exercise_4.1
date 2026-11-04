import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('MegaMind Pizza App smoke test', (WidgetTester tester) async {
    // Launch the application.
    await tester.pumpWidget(const MegaMindPizzaApp());

    // Verify that the application starts successfully.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
