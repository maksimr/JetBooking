import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/screens/DetailsScreen.dart';

void main() {
  testWidgets('should create screen', (WidgetTester tester) async {
    final date = DateTime.now();
    await tester.pumpWidget(AppTheme(
      child: DetailsScreen(date: date),
    ));

    expect(find.byType(DetailsScreen), findsOneWidget);
  });
}
