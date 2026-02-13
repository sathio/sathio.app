// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:sathio/main.dart';

void main() {
  testWidgets('Onboarding Screen UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our title text is present.
    expect(find.text('Sathio'), findsOneWidget);
    expect(find.text('Bharat ki Awaaz'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
