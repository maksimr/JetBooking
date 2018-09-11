import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:jetbooking/api/vc.dart';
import '../http.dart';
import 'vc.dart';

void main() {
  test('should return list of rooms', () {
    runHttpZoned((client) async {
      when(client.getUrl(vcUrl("getRooms")))
          .thenAnswer(response(toJson([createRoomMock()])));
      final List data = await getRooms();
      expect(data.length, 1);
    });
  });

  test("should return list of available rooms", () {
    runHttpZoned((client) async {
      final startTime = DateTime(2018, 1, 1, 1, 30);
      final endTime = DateTime(2018, 1, 1, 2, 30);

      when(client.getUrl(vcVacantRoomsUrlFor(startTime, endTime)))
          .thenAnswer(response(toJson([createRoomMock()])));

      final List data = await getVacantRooms(
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
      );
      expect(data.length, 1);
    });
  });

  test("should return list of rooms with TV", () {
    runHttpZoned((client) async {
      final startTime = DateTime(2018, 1, 1, 1, 30);
      final endTime = DateTime(2018, 1, 1, 2, 30);

      when(client.getUrl(vcVacantRoomsUrlFor(startTime, endTime, hasTv: true)))
          .thenAnswer(response(toJson([createRoomMock()])));

      final List data = await getVacantRooms(
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
          hasTv: true);

      expect(data.length, 1);
    });
  });
}
