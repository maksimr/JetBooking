import 'dart:io';
import 'package:test/test.dart';
import 'package:jetbooking/api/vc.dart';
import 'vc.dart';

void main() {
  test('should return list of rooms', () {
    HttpOverrides.runZoned(() async {
      final List data = await getRooms();
      expect(data.length, 1);
    },
        createHttpClient: (_) =>
            whenGetUrl(vcUrl("getRooms"), [createRoomMock()]));
  });

  test("should return list of available rooms", () {
    final startTime = DateTime(2018, 1, 1, 1, 30).millisecondsSinceEpoch;
    final endTime = DateTime(2018, 1, 1, 2, 30).millisecondsSinceEpoch;

    HttpOverrides.runZoned(() async {
      final List data = await getVacantRooms(
        startTime: startTime,
        endTime: endTime,
      );
      expect(data.length, 1);
    },
        createHttpClient: (_) => whenGetUrl(
            vcVacantRoomsUrl(startTime, endTime), [createRoomMock()]));
  });

  test("should return list of rooms with TV", () {
    final startTime = DateTime(2018, 1, 1, 1, 30).millisecondsSinceEpoch;
    final endTime = DateTime(2018, 1, 1, 2, 30).millisecondsSinceEpoch;

    HttpOverrides.runZoned(() async {
      final List data = await getVacantRooms(
          startTime: startTime, endTime: endTime, hasTv: true);
      expect(data.length, 1);
    },
        createHttpClient: (_) => whenGetUrl(
            vcVacantRoomsUrl(startTime, endTime, hasTv: true),
            [createRoomMock()]));
  });
}
