import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/components/Picker.dart';
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

    expect(findItem("Starts", "11:30"), findsOneWidget);
  });

  testWidgets('should change start date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    await tester.tap(findItem("Starts"));
    await tester.pump();

    await jumpToDateTime(tester, hours: 12);

    expect(findItem("Starts", "12:30"), findsOneWidget);
  });

  testWidgets('should render end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expect(findItem("Ends", "12:00"), findsOneWidget);
  });

  testWidgets('should change end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 00);
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    await tester.tap(findItem("Ends"));
    await tester.pump();

    await jumpToDateTime(tester, hours: 12);

    expect(findItem("Ends", "12:30"), findsOneWidget);
  });

  testWidgets('should render recurring item', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expect(findItem("Recurring", null), findsOneWidget);
  });

  testWidgets('should render offline rooms control',
      (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expect(findItem("Offline rooms", null), findsOneWidget);
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

  testWidgets('should render inline calendar', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

    expect(find.byType(InlineCalendar), findsOneWidget);
  });
}

findItem(text, [value]) {
  return value == null
      ? find.text(text)
      : find.descendant(
          of: findItemByText(text),
          matching: find.text(value),
        );
}

findItemByText(text) {
  return find.ancestor(
    of: find.text(text),
    matching: find.byType(ListTile),
  );
}

jumpToDateTime(tester, {hours, minutes}) async {
  if (hours != null) jumpToItem(tester, find.byType(Picker).at(0), hours);
  if (minutes != null)
    jumpToItem(tester, find.byType(Picker).at(1), minutes ~/ 5);
  await tester.pump();
}

jumpToItem(tester, finder, itemIndex) {
  Picker minPicker = tester.widget(finder);
  minPicker.controller.jumpToItem(itemIndex);
}
