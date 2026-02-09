// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sathio/main.dart';

void main() {
  testWidgets('App launches and shows home screen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    // We need to wrap the app in a ProviderScope for Riverpod to work
    await tester.pumpWidget(const ProviderScope(child: SathioApp()));

    // Verify that our home screen text is present.
    expect(find.text('Welcome to Sathio'), findsOneWidget);
    expect(find.text('Go to Auth Test'), findsOneWidget);
  });
}
