import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:jetbooking/api/vc.dart';

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
        createHttpClient: (_) =>
            whenGetUrl(vcUrl("getVacantRooms?startTime=${startTime /
                1000}&endTime=${endTime /
                1000}"), [createRoomMock()]));
  });
}

whenGetUrl(url, responseData) {
  final MockHttpClient client = new MockHttpClient();

  when(client.getUrl(url)).thenAnswer((Invocation _) {
    final MockHttpClientRequest request = new MockHttpClientRequest();
    final MockHttpClientResponse response = new MockHttpClientResponse();
    when(request.close()).thenAnswer((_) => Future.value(response));
    when(response.transform(any)).thenAnswer((invocation) {
      final decoder = invocation.positionalArguments[0];
      return Stream
          .fromFuture<List<int>>(
              Future.value(utf8.encode(json.encode(responseData))))
          .transform(decoder);
    });
    return Future.value(request);
  });

  return client;
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

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}
