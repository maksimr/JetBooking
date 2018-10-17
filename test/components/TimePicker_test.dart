import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/TimePicker.dart';

import 'TimePicker.dart';

void main() {
  setUp(() {
    WidgetsBinding.instance.renderView.configuration =
        new TestViewConfiguration(size: const Size(1200.0, 1980.0));
  });

  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: TimePicker(),
    ));

    expect(find.byType(TimePicker), findsOneWidget);
  });

  testWidgets('should render hours', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: 30 * 24.0, width: 20.0),
          child: TimePicker(),
        ),
      ),
    ));

    expect(find.byType(TimePickerHourItem), findsNWidgets(25));
  });

  testWidgets('should render minutes with 5 min interval',
      (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: 30 * 12.0, width: 20.0),
          child: TimePicker(),
        ),
      ),
    ));

    expect(find.byType(TimePickerMinItem), findsNWidgets(13));
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
