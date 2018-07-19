import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Calendar.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: Calendar(),
    ));
  });

  testWidgets('should render toolbar', (WidgetTester tester) async {
    final calendarWidget = Calendar();
    await tester.pumpWidget(AppTheme(child: calendarWidget));
    expect(find.byKey(calendarWidget.toolbarKey), findsOneWidget);
  });

  testWidgets('should render calendar body', (WidgetTester tester) async {
    final calendarWidget = Calendar();
    await tester.pumpWidget(AppTheme(child: calendarWidget));
    expect(find.byKey(calendarWidget.calendarKey), findsOneWidget);
  });

  testWidgets(
      'should render only monthes for current year and start from month of passed date',
      (WidgetTester tester) async {
    final date = DateTime(2018, DateTime.july);
    final calendarWidget = Calendar(date: date);
    double scrollOffset = 0.0;
    jumpOnNextMonth() async => await jumpTo(tester, scrollOffset += 400);
    monthTitle(DateTime date) => DateFormat.MMMM().format(date);

    await tester.pumpWidget(AppTheme(child: calendarWidget));

    expect(
        find.text(monthTitle(DateTime(2018, DateTime.july))), findsOneWidget);
    expect(
        find.text(monthTitle(DateTime(2018, DateTime.august))), findsOneWidget);

    for (int month in [
      DateTime.september,
      DateTime.october,
      DateTime.november,
      DateTime.december,
    ]) {
      await jumpOnNextMonth();
      expect(find.text(monthTitle(DateTime(2018, month))), findsOneWidget);
    }

    await jumpOnNextMonth();
    expect(
        find.text(monthTitle(DateTime(2019, DateTime.january))), findsNothing);
  });
}

Future jumpTo(tester, double newScrollOffset) async {
  final ScrollableState scrollable = tester.state(find.byType(Scrollable));
  scrollable.position.jumpTo(newScrollOffset);
  await tester.pump();
}
