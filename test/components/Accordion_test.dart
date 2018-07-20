import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/Accordion.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: Accordion(),
    ));
  });

  testWidgets('should render a widget as a pane', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: Accordion(
        children: <Widget>[
          Text("A"),
        ],
      ),
    ));

    expect(find.text("A"), findsOneWidget);
  });

  testWidgets('should render accordion pane', (WidgetTester tester) async {
    final paneA = AccordionPane(title: Text("A"), child: Text("AA"));

    await tester.pumpWidget(AppTheme(
      child: Accordion(
        children: <Widget>[paneA],
      ),
    ));

    expect(find.text("A"), findsOneWidget);
    expect(find.text("AA"), findsNothing);
  });

  testWidgets('should expand accordion pane by tap',
      (WidgetTester tester) async {
    final paneA = AccordionPane(title: Text("A"), child: Text("AA"));

    await tester.pumpWidget(AppTheme(
      child: Accordion(
        children: <Widget>[paneA],
      ),
    ));

    await tester.tap(find.byType(AccordionPane));
    await tester.pumpAndSettle();

    expect(find.text("AA"), findsOneWidget);
  });

  testWidgets('should collapse previous expanded pane and expand new',
      (WidgetTester tester) async {
    final paneA = AccordionPane(title: Text("A"), child: Text("AA"));
    final paneB = AccordionPane(title: Text("B"), child: Text("BB"));

    await tester.pumpWidget(AppTheme(
      child: Accordion(
        children: <Widget>[
          paneA,
          paneB,
        ],
      ),
    ));

    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();

    expect(find.text("AA"), findsOneWidget);
    expect(find.text("BB"), findsNothing);

    await tester.tap(find.text("B"));
    await tester.pumpAndSettle();

    expect(find.text("BB"), findsOneWidget);
    expect(find.text("AA"), findsNothing);
  });
}
