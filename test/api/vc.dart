import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:jetbooking/api/vc.dart';
import 'package:mockito/mockito.dart';

createVacantRoomsRunZoneFor({startTime, endTime, rooms, hasTv = false}) =>
    (body) => HttpOverrides.runZoned(body,
        createHttpClient: (_) => whenGetUrl(
            vcVacantRoomsUrl(startTime, endTime, hasTv: hasTv), rooms));

vcVacantRoomsUrl(startTime, endTime, {bool hasTv = false}) {
  return vcUrl("getVacantRooms?startTime=${startTime ~/
      1000}&endTime=${endTime ~/
      1000}&hasTv=$hasTv");
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
