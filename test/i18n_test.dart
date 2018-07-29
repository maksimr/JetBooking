import 'package:jetbooking/i18n.dart';
import 'package:test/test.dart';

void main() {
  test('should return translated string', () {
    expect(i18n("Test"), "Test");
  });
}
