import 'package:jetbooking/api/vc.dart';

vcVacantRoomsUrlFor(DateTime startDate, DateTime endDate,
    {bool hasTv = false}) {
  final startTime = startDate.millisecondsSinceEpoch;
  final endTime = endDate.millisecondsSinceEpoch;
  return vcUrl(
      "getVacantRooms?startTime=${startTime ~/ 1000}&endTime=${endTime ~/ 1000}&hasTv=$hasTv");
}

createRoomMock() {
  return {
    "id": "KQPjltJIA6GHhSLfLG2fRT",
    "title": "San Francisco-113",
    "description": "Number (H.232): 22032",
    "location": "San Francisco",
    "locationId": "-X4KZApLfg.CvpYyK89qVE",
    "floor": 1,
    "capacity": 10,
    "hasTv": true
  };
}
