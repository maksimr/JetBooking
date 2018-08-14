import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
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
}
