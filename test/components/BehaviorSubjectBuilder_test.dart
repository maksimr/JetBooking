import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:jetbooking/components/BehaviorSubjectBuilder.dart';

void main() {
  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(BehaviorSubjectBuilder(
      subject: BehaviorSubject(seedValue: 0),
      builder: (BuildContext context, AsyncSnapshot snapshot) => Container(),
    ));
  });
}
