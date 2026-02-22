// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  testWidgets('Expense tracker renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Expenses())));

    // Verify that the app renders with expected content
    expect(find.text('Flutter Expense Tracker'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
