import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Calendar.dart';
import 'package:jetbooking/screens/CalendarScreen.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: CalendarScreen(),
    ));

    expect(find.byType(Calendar), findsOneWidget);
  });
}
