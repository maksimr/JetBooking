import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/controllers/DetailsScreenController.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';
import 'package:mockito/mockito.dart';
import '../api/vc.dart';
import '../components/TimePicker.dart';
import '../components/VacantRooms.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    expect(find.byType(DetailsScreen), findsOneWidget);
  });

  testWidgets('should render app bar', (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('should render start date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));
    ctrl.startDate = date;
    await eventFiring(tester);

    expect(findItem("Starts", "11:30"), findsOneWidget);
  });

  testWidgets('should change start date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.startDate = date;
    await eventFiring(tester);

    await tester.tap(findItem("Starts"));
    await tester.pump();

    await jumpToDateTime(tester, hours: 12);

    expect(findItem("Starts", "12:30"), findsOneWidget);
  });

  testWidgets('should render end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.endDate = date.add(Duration(minutes: 30));
    await eventFiring(tester);

    expect(findItem("Ends", "12:00"), findsOneWidget);
  });

  testWidgets('should change end date item', (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 00);
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.endDate = date.add(Duration(minutes: 30));
    await eventFiring(tester);

    await tester.tap(findItem("Ends"));
    await tester.pump();

    await jumpToDateTime(tester, hours: 12);

    expect(findItem("Ends", "12:30"), findsOneWidget);
  });

  testWidgets('should render recurring item', (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    expect(findItem("Recurring", null), findsOneWidget);
  });

  testWidgets('should render offline rooms control',
      (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.hasTv = false;
    await eventFiring(tester);

    expect(findItem("Offline rooms", null), findsOneWidget);
  });

  testWidgets('should render month in the app bar',
      (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));
    await eventFiring(tester);

    expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(DateFormat.MMMM().format(date)),
        ),
        findsOneWidget);
  });

  testWidgets('should render rooms list', (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.rooms = [createRoomMock()];
    await eventFiring(tester);

    expect(findVacantRooms(), findsOneWidget);
  });

  testWidgets('should render inline calendar', (WidgetTester tester) async {
    final date = DateTime.now();
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.startDate = date;
    await eventFiring(tester);

    expect(find.byType(InlineCalendar), findsOneWidget);
  });

  testWidgets('should select date from inline calendar',
      (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    final newDate = date.add(Duration(days: 1));
    final ctrl = DetailsScreenControllerMock(date);

    expect(ctrl.startDate, emitsInOrder([date, newDate]));

    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    ctrl.startDate = date;
    await eventFiring(tester);
    await tapOnDayInCalendar(tester, newDate);
  }, timeout: Timeout(Duration(milliseconds: 10)));

  testWidgets(
      'should preserve hours and minutes when change date by inline calendar',
      (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.june, 1, 11, 30);
    final ctrl = DetailsScreenControllerMock(date);
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date, ctrl: ctrl),
    ));

    expect(
        ctrl.startDate,
        emitsInOrder([
          date,
          date.add(Duration(hours: 1)),
          date.add(Duration(days: 1, hours: 1)),
        ]));

    ctrl.startDate = date;
    await eventFiring(tester);

    await tester.tap(findItem("Starts"));
    await tester.pump();
    await jumpToDateTime(tester, hours: 12);

    await tapOnDayInCalendar(tester, date.add(Duration(days: 1)));
    await eventFiring(tester);
  }, timeout: Timeout(Duration(milliseconds: 10)));
}

eventFiring(WidgetTester tester) async {
  await tester.pump(Duration.zero);
}

tapOnDayInCalendar(tester, date) async {
  return tester.tap(find.descendant(
    of: find.byType(InlineCalendar),
    matching: find.text(date.day.toString()),
  ));
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

class DetailsScreenControllerMock extends Mock
    implements DetailsScreenController {
  DetailsScreenControllerMock(this.date);

  final date;
  final startDateCtrl = StreamController.broadcast();
  final endDateCtrl = StreamController.broadcast();
  final roomsCtrl = StreamController.broadcast();
  final hasTvCtrl = StreamController.broadcast();

  get startDate => startDateCtrl.stream;

  get endDate => endDateCtrl.stream;

  get rooms => roomsCtrl.stream;

  get hasTv => hasTvCtrl.stream;

  set startDate(value) => startDateCtrl.add(value);

  set endDate(value) => endDateCtrl.add(value);

  set rooms(value) => roomsCtrl.add(value);

  set hasTv(value) => hasTvCtrl.add(value);
}
