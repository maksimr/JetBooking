import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Calendar.dart';
import 'package:jetbooking/components/CalendarMonth.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';
import 'package:jetbooking/screens/CalendarScreen.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: CalendarScreen(),
    ));

    expect(find.byType(Calendar), findsOneWidget);
  });

  testWidgets('should open booking details screen when user tap on a day',
      (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.july);

    await tester.pumpWidget(AppTheme(
      child: CalendarScreen(date: date),
    ));

    await tapOnDate(tester, date);
    await tester.pumpAndSettle();

    expect(find.byType(DetailsScreen), findsOneWidget);
  });
}

tapOnDate(tester, date) async {
  return await tester.tap(find.descendant(
    of: find.ancestor(
      of: find.widgetWithText(
        CalendarMonthTitle,
        CalendarMonthTitle.formatDate(date),
      ),
      matching: find.byType(CalendarMonth),
    ),
    matching: find.text("${date.day}"),
  ));
}
