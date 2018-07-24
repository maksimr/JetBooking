import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
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
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expectFindOneItemWidget("Starts", "11:30");
  });

  testWidgets('should render end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expectFindOneItemWidget("Ends", "12:00");
  });

  testWidgets('should render recurring item', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expectFindOneItemWidget("Recurring");
  });

  testWidgets('should render offline rooms control',
      (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expectFindOneItemWidget("Offline rooms");
  });

  testWidgets('should render month in the app bar',
      (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(DateFormat.MMMM().format(date)),
        ),
        findsOneWidget);
  });
}

expectFindOneItemWidget(text, [value]) {
  if (value == null) {
    expect(find.text(text), findsOneWidget);
    return;
  }

  expect(
      find.descendant(
        of: findItemByText(text),
        matching: find.text(value),
      ),
      findsOneWidget);
}

findItemByText(text) {
  return find.ancestor(
    of: find.text(text),
    matching: find.byType(ListTile),
  );
}
