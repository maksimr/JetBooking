import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/WeekDay.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: WeekDay(
        weekday: DateTime.wednesday,
      ),
    ));

    expect(find.byType(WeekDay), findsOneWidget);
  });
}
