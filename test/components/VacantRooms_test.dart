import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/VacantRooms.dart';

import '../api/vc.dart';

void main() {
  final startTime = DateTime(2018, 1, 1, 1, 30);
  final endTime = startTime.add(Duration(hours: 1));
  final rooms = [createRoomMock()];
  final runZoneWithRooms = createVacantRoomsRunZoneFor(
    startTime: startTime.millisecondsSinceEpoch,
    endTime: endTime.millisecondsSinceEpoch,
    rooms: rooms,
  );

  testWidgets('should create widget', (WidgetTester tester) async {
    runZoneWithRooms(() async {
      await tester.pumpWidget(AppTheme(
        child: VacantRooms(
          startTime: startTime,
          endTime: endTime,
        ),
      ));

      expect(find.byType(VacantRooms), findsOneWidget);
    });
  });

  testWidgets('should render room', (WidgetTester tester) async {
    runZoneWithRooms(() async {
      await tester.pumpWidget(AppTheme(
        child: VacantRooms(
          startTime: startTime,
          endTime: endTime,
        ),
      ));

      await waitFutureBuilder(tester);

      expect(find.byType(ListTile), findsNWidgets(rooms.length));
    });
  });
}

waitFutureBuilder(tester) async {
  await (tester.widget(find.byType(FutureBuilder)) as FutureBuilder).future;
  await tester.pumpAndSettle();
}
