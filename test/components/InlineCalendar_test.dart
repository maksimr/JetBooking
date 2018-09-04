import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/CalendarDay.dart';
import 'package:jetbooking/components/InlineCalendar.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: InlineCalendar(seedDate: date),
    ));

    expect(find.byType(InlineCalendar), findsOneWidget);
  });

  testWidgets('should render days', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: InlineCalendar(
        seedDate: date,
      ),
    ));

    expect(find.byType(CalendarDay), findsWidgets);
  });

  testWidgets('should allow set selected date', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: InlineCalendar(
        seedDate: date,
        date: date.add(Duration(days: 1)),
      ),
    ));

    expect(find.byType(CalendarDay), findsWidgets);
  });
}
