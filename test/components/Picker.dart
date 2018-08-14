import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/Picker.dart';

findPicker() {
  return find.byType(Picker);
}

pickItem(WidgetTester tester, Finder finder, int itemIndex) {
  Picker minPicker = tester.widget(finder);
  minPicker.controller.jumpToItem(itemIndex);
}
