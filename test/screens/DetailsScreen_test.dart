import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date),
    ));

    expect(find.byType(DetailsScreen), findsOneWidget);
  });

  testWidgets('should render app bar', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date),
    ));

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('should render start date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date),
    ));

    final item = find.ancestor(
      of: find.text("Starts"),
      matching: find.byType(ListTile),
    );

    expect(find.descendant(of: item, matching: find.text("11:30")),
        findsOneWidget);
  });

  testWidgets('should render end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date),
    ));

    final item = find.ancestor(
      of: find.text("Ends"),
      matching: find.byType(ListTile),
    );

    expect(find.descendant(of: item, matching: find.text("12:00")),
        findsOneWidget);
  });
}
