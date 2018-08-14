import 'package:flutter_test/flutter_test.dart';

import 'Picker.dart';

jumpToDateTime(WidgetTester tester, {hours, minutes}) async {
  if (hours != null) pickItem(tester, findPicker().at(0), hours);
  if (minutes != null) pickItem(tester, findPicker().at(1), minutes ~/ 5);
  await tester.pump();
}
