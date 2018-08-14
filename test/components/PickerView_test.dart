import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/PickerView.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: PickerView(
        itemExtent: 20.0,
        children: [],
        onSelectedItemChanged: null,
      ),
    ));

    expect(find.byType(PickerView), findsOneWidget);
  });

  testWidgets('should render items', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: PickerView(
        itemExtent: 20.0,
        children: [Text("A")],
        onSelectedItemChanged: null,
      ),
    ));

    expect(find.text("A"), findsOneWidget);
  });

  testWidgets('should call select handler', (WidgetTester tester) async {
    var controller = FixedExtentScrollController();
    var selectedIndex = 0;

    await tester.pumpWidget(AppTheme(
      child: PickerView(
        controller: controller,
        itemExtent: 20.0,
        children: List<Widget>.generate(24, (it) => Text("it")),
        onSelectedItemChanged: (index) => selectedIndex = index,
      ),
    ));

    controller.jumpToItem(1);
    await tester.pump();

    expect(selectedIndex, 1);
  });
}
