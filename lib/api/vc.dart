import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

getRooms() async => vcRequest<List>("getRooms");

Future<List> getVacantRooms({
  @required int startTime,
  @required int endTime,
  bool hasTv = false,
}) async {
  final startTimeInSeconds = startTime ~/ 1000;
  final endTimeInSeconds = endTime ~/ 1000;
  return vcRequest<List>(
      "getVacantRooms?startTime=$startTimeInSeconds&endTime=$endTimeInSeconds&hasTv=$hasTv");
}

Future<T> vcRequest<T>(path) async {
  final client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  final request = await client.getUrl(vcUrl(path));
  final resp = await request.close();
  final T data = json.decode(await resp.transform(utf8.decoder).join(""));
  return data;
}

vcUrl(path) {
  return Uri.parse("https://vc.labs.intellij.net/api/rest/$path");
}
