import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/App.dart';
import 'package:jetbooking/components/CalendaryDay.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(App(child: CalendarDay()));
  });

  testWidgets('should render passed day', (WidgetTester tester) async {
    final date = DateTime.now();
    final dayWidget = CalendarDay(date: date);

    await tester.pumpWidget(App(child: dayWidget));

    expect(find.text('${date.day}'), findsOneWidget);
    checkDayWidgetColor(tester, dayWidget, null);
  });

  testWidgets('should highlight selected day', (WidgetTester tester) async {
    final date = DateTime.now();
    final dayWidget = CalendarDay(
      date: date,
      selected: true,
    );

    await tester.pumpWidget(App(child: dayWidget));
    checkDayWidgetColor(
      tester,
      dayWidget,
      getTheme(tester, dayWidget).accentColor,
    );
  });
}

createDayContainerFinder(dayWidget) {
  return find.byKey(dayWidget.containerKey);
}

getTheme(WidgetTester tester, CalendarDay dayWidget) =>
    Theme.of(tester.element(createDayContainerFinder(dayWidget)));

checkDayWidgetColor(tester, dayWidget, expectedColor) {
  final BoxDecoration decoration =
      (tester.widget(createDayContainerFinder(dayWidget)) as Container)
          .decoration;
  expect(decoration.color, equals(expectedColor));
}
