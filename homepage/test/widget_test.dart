import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homepage/main.dart';

void main() {
  testWidgets('MegaMind Pizza App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const MegaMindPizzaApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
