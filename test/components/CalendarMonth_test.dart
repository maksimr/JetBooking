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
}
