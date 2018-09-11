import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/AppTheme.dart';
import 'package:jetbooking/components/VacantRooms.dart';

import '../api/vc.dart';
import 'VacantRooms.dart';

void main() {
  final rooms = [createRoomMock()];

  testWidgets('should create widget', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: VacantRooms(rooms: rooms),
    ));

    expect(find.byType(VacantRooms), findsOneWidget);
  });

  testWidgets('should render rooms', (WidgetTester tester) async {
    await tester.pumpWidget(AppTheme(
      child: VacantRooms(rooms: rooms),
    ));

    expect(findVacantRooms(), findsNWidgets(rooms.length));
  });
}
