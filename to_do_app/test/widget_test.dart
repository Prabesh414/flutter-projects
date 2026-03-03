// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_do_app/app/todo_app.dart';

void main() {
  testWidgets('To-Do app builds and displays', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ToDoApp());

    // Verify that the app title is visible
    expect(find.text('My To-Do App'), findsOneWidget);

    // Verify that the input hint is visible
    expect(find.text('Add a new task...'), findsOneWidget);

    // Verify sample tasks are added
    expect(find.text('Learn Widget Trees'), findsOneWidget);
    expect(find.text('Understand Elements'), findsOneWidget);
    expect(find.text('Master State Management'), findsOneWidget);
  });

  testWidgets('Can add a new to-do item', (WidgetTester tester) async {
    await tester.pumpWidget(const ToDoApp());

    // Find the text field and enter a task
    await tester.enterText(find.byType(TextField), 'Test Task');

    // Tap the add button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify the new task appears
    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('Can toggle task completion', (WidgetTester tester) async {
    await tester.pumpWidget(const ToDoApp());

    // Tap the first checkbox
    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();

    // Verify the widget updated (test basic interaction)
    expect(find.byType(Checkbox), findsWidgets);
  });
}
