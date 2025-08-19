import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen basic UI and interaction test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomeScreen())),
    );
    // Testing Add task button with TextField.
    final textField = find.byType(TextField).first;
    await tester.enterText(textField, 'This is testing task');
    await tester.pumpAndSettle();
    expect(find.text('This is testing task'), findsOneWidget);

    final addButton = find.text('Add');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Finding ListView.builder after adding a task
    expect(find.byType(ListView).first, findsOneWidget);
    expect(find.text('This is testing task'), findsOneWidget);

    // Testing search field by entering different task
    final search = find.byType(TextField).last;
    await tester.enterText(search, 'Dummy Task');
    await tester.pumpAndSettle();
    expect(find.text('No Tasks'), findsOneWidget);
    await tester.enterText(search, '');
    await tester.pumpAndSettle();

    // Finding progress indicator
    expect(find.text('0/1'), findsOneWidget);

    // Testing Active button
    await tester.tap(find.text('Active'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView).first, findsOneWidget);
    expect(find.text('This is testing task'), findsOneWidget);

    // Making a task completed
    await tester.tap(find.byIcon(Icons.circle_outlined).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('This is testing task'), findsOneWidget);

    // Deleting a task and testing snackBar
    await tester.tap(find.byIcon(Icons.cancel_outlined).first);
    await tester.pumpAndSettle();
    expect(find.text('Task "This is testing task" has been deleted'), findsOneWidget);
  });
}
