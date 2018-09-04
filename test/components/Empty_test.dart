import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/Empty.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(Empty());
  });
}
