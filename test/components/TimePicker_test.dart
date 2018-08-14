import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Picker.dart';
import 'package:jetbooking/components/TimePicker.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: TimePicker(),
    ));

    expect(find.byType(TimePicker), findsOneWidget);
  });

  testWidgets('should render hours', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: TimePicker(),
    ));

    expect(find.byType(TimePickerHourItem), findsNWidgets(24));
  });

  testWidgets('should render minutes with 5 min interval',
      (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: TimePicker(),
    ));

    expect(find.byType(TimePickerMinItem), findsNWidgets(12));
  });

  testWidgets('should change hour', (WidgetTester tester) async {
    DateTime initDate = DateTime(2018, 1, 1, 2, 30);
    DateTime date = initDate;
    await tester.pumpWidget(AppTheme(
      child: TimePicker(
        date: initDate,
        onSelectedDateChanged: (newDate) => date = newDate,
      ),
    ));

    await jumpToDateTime(tester, hours: 3);

    expect(date.difference(initDate), Duration(hours: 1));
  });

  testWidgets('should change minutes', (WidgetTester tester) async {
    DateTime initDate = DateTime(2018, 1, 1, 2, 30);
    DateTime date = initDate;
    await tester.pumpWidget(AppTheme(
      child: TimePicker(
        date: initDate,
        onSelectedDateChanged: (newDate) => date = newDate,
      ),
    ));

    await jumpToDateTime(tester, minutes: 35);

    expect(date.difference(initDate), Duration(minutes: 5));
  });

  testWidgets('should change hour and minutes', (WidgetTester tester) async {
    DateTime initDate = DateTime(2018, 1, 1, 2, 30);
    DateTime date = initDate;
    await tester.pumpWidget(AppTheme(
      child: TimePicker(
        date: initDate,
        onSelectedDateChanged: (newDate) => date = newDate,
      ),
    ));

    await jumpToDateTime(tester, hours: 3, minutes: 35);

    expect(date.difference(initDate), Duration(hours: 1, minutes: 5));
  });
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
