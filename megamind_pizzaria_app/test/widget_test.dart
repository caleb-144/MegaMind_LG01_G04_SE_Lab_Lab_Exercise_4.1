import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('MegaMind Pizza App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MegaMindPizzaApp());

    // Check whether Flutter encountered an exception.
    final exception = tester.takeException();

    expect(
      exception,
      isNull,
      reason: 'MegaMind Pizza App encountered an error during startup: $exception',
    );
  });
}
