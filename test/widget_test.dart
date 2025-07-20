// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calc_kids/main.dart';

void main() {
  testWidgets('Pressing a digit updates display', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.text('1'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Performs integer calculation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('1'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Performs decimal calculation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('1'));
    await tester.tap(find.text('÷'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('0,5'), findsOneWidget);
  });
}
