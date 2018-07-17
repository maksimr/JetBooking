import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme());
  });
}
