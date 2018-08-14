import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Picker.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: Picker(
        itemExtent: 20.0,
        children: [],
        onSelectedItemChanged: null,
      ),
    ));

    expect(find.byType(Picker), findsOneWidget);
  });

  testWidgets('should select initial value', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: Picker(
        itemExtent: 20.0,
        initialItem: 8,
        children: List.generate(10, (it) => Text("$it")),
        onSelectedItemChanged: (it) => print(it),
      ),
    ));

    expect(find.text("8"), findsOneWidget);
  });
}
