import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/VacantRooms.dart';

import '../api/vc.dart';
import 'VacantRooms.dart';

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

  testWidgets('should render rooms', (WidgetTester tester) async {
    runZoneWithRooms(() async {
      await tester.pumpWidget(AppTheme(
        child: VacantRooms(
          startTime: startTime,
          endTime: endTime,
        ),
      ));

      await waitWhenVacantRoomsAreLoaded(tester);

      expect(findVacantRooms(), findsNWidgets(rooms.length));
    });
  });

  testWidgets('should render rooms with TV only', (WidgetTester tester) async {
    createVacantRoomsRunZoneFor(
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      rooms: rooms,
      hasTv: true,
    )(() async {
      await tester.pumpWidget(AppTheme(
        child: VacantRooms(
          startTime: startTime,
          endTime: endTime,
          hasTv: true,
        ),
      ));

      await waitWhenVacantRoomsAreLoaded(tester);

      expect(findVacantRooms(), findsNWidgets(rooms.length));
    });
  });
}
