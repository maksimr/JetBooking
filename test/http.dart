import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mockito/mockito.dart';

runHttpZoned(body) {
  final MockHttpClient client = new MockHttpClient();
  return HttpOverrides.runZoned(() => body(client),
      createHttpClient: (_) => client);
}

dumbZone<T>(body) {
  HttpOverrides.runZoned<T>(body, createHttpClient: (_) {
    final MockHttpClient client = new MockHttpClient();
    when(client.getUrl(any)).thenAnswer(response(toJson([])));
    return client;
  });
}

response(String data, [statusCode = 200]) {
  return (Invocation _) {
    final MockHttpClientRequest request = new MockHttpClientRequest();
    final MockHttpClientResponse response = new MockHttpClientResponse();
    when(request.close()).thenAnswer((_) => Future.value(response));
    when(response.statusCode).thenAnswer((_) => statusCode);
    when(response.transform(any)).thenAnswer((invocation) {
      final decoder = invocation.positionalArguments[0];
      return Stream.fromFuture<List<int>>(Future.value(utf8.encode(data)))
          .transform(decoder);
    });
    return Future.value(request);
  };
}

toJson(text) {
  return json.encode(text);
}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}
