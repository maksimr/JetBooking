import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/InlineCalendar.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';
import 'package:mockito/mockito.dart';

import '../http.dart';
import '../api/vc.dart';
import '../components/TimePicker.dart';
import '../components/VacantRooms.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(
        child: DetailsScreen(date: date),
      ));

      expect(find.byType(DetailsScreen), findsOneWidget);
    });
  });

  testWidgets('should render app bar', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(
        child: DetailsScreen(date: date),
      ));

      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  testWidgets('should render start date item', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      expect(findItem("Starts", "11:30"), findsOneWidget);
    });
  });

  testWidgets('should change start date item', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      await tester.tap(findItem("Starts"));
      await tester.pump();

      await jumpToDateTime(tester, hours: 12);

      expect(findItem("Starts", "12:30"), findsOneWidget);
    });
  });

  testWidgets('should render end date item', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      expect(findItem("Ends", "12:00"), findsOneWidget);
    });
  });

  testWidgets('should change end date item', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 00);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      await tester.tap(findItem("Ends"));
      await tester.pump();

      await jumpToDateTime(tester, hours: 12);

      expect(findItem("Ends", "12:30"), findsOneWidget);
    });
  });

  testWidgets('should render recurring item', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));

      expect(findItem("Recurring", null), findsOneWidget);
    });
  });

  testWidgets('should render offline rooms control',
      (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      expect(findItem("Offline rooms", null), findsOneWidget);
    });
  });

  testWidgets('should render month in the app bar',
      (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text(DateFormat.MMMM().format(date)),
          ),
          findsOneWidget);
    });
  });

  testWidgets('should render inline calendar', (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime.now();
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      expect(find.byType(InlineCalendar), findsOneWidget);
    });
  });

  testWidgets(
      'should automaticaly change end time when user change start time to keep duration',
      (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      await tester.tap(findItem("Starts"));
      await tester.pump();

      await jumpToDateTime(tester, hours: 12);
      await eventFiring(tester);

      expect(findItem("Starts", "12:30"), findsOneWidget);
      expect(findItem("Ends", "13:00"), findsOneWidget);
    });
  });

  testWidgets('should render rooms', (WidgetTester tester) async {
    runHttpZoned((client) async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      final startTime = date;
      final endTime = date.add(Duration(minutes: 30));
      final rooms = [createRoomMock()];

      when(client.getUrl(vcVacantRoomsUrlFor(startTime, endTime)))
          .thenAnswer(responseMock(rooms));

      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);
      expect(findVacantRooms(), findsNWidgets(rooms.length));
    });
  });

  testWidgets('should select date from inline calendar',
      (WidgetTester tester) async {
    runHttpZoned((client) async {
      final duration = Duration(minutes: 30);

      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      final rooms = [];
      when(client.getUrl(vcVacantRoomsUrlFor(date, date.add(duration))))
          .thenAnswer(responseMock(rooms));

      final newDate = date.add(Duration(days: 1));
      final roomsForNewDate = [createRoomMock()];
      when(client.getUrl(vcVacantRoomsUrlFor(newDate, newDate.add(duration))))
          .thenAnswer(responseMock(roomsForNewDate));

      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);
      expect(findVacantRooms(), findsNWidgets(rooms.length));

      await tapOnDayInCalendar(tester, newDate);
      await eventFiring(tester);
      expect(findVacantRooms(), findsNWidgets(roomsForNewDate.length));
    });
  });

  testWidgets(
      'should preserve hours and minutes when change date by inline calendar',
      (WidgetTester tester) async {
    dumbZone(() async {
      final date = DateTime(2018, DateTime.june, 1, 11, 30);
      await tester.pumpWidget(AppTheme(child: DetailsScreen(date: date)));
      await eventFiring(tester);

      await tester.tap(findItem("Starts"));
      await tester.pump();
      await jumpToDateTime(tester, hours: 12);

      await tapOnDayInCalendar(tester, date.add(Duration(days: 1)));
      await eventFiring(tester);
      expect(findItem("Starts", "12:30"), findsOneWidget);
    });
  });
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
