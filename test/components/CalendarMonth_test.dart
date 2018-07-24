import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/CalendarMonth.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: CalendarMonth(
        date: date,
        dayBuilder: (BuildContext context, DateTime date) {
          return Text("${date?.day}");
        },
      ),
    ));

    expect(find.text('${date.day}'), findsOneWidget);
  });

  testWidgets('should generate week rows', (WidgetTester tester) async {
    final date = DateTime(2018, 7, 17);
    final monthWidget = CalendarMonth(
      date: date,
      dayBuilder: (BuildContext context, DateTime date) {
        return Text("${date?.day}");
      },
    );

    expect(monthWidget.weeksList.length, equals(6));
  });

  testWidgets(
      'should shift first day of the month if it is not a first day of the week',
      (WidgetTester tester) async {
    final date = DateTime(2018, 7, 17);
    final monthWidget = CalendarMonth(
      date: date,
      dayBuilder: (BuildContext context, DateTime date) {
        return Text("${date?.day}");
      },
    );

    expect(monthWidget.weeksList[0][DateTime.sunday - 1].day, equals(1));
  });

  testWidgets('should render month title', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: CalendarMonth(
        title: CalendarMonthTitle(date: date),
        date: date,
        dayBuilder: (BuildContext context, DateTime date) {
          return Text("${date?.day}");
        },
      ),
    ));

    expect(find.text(CalendarMonthTitle.formatDate(date)), findsOneWidget);
  });
}
