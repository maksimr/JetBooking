import 'package:flutter/material.dart';
import 'package:jetbooking/api/vc.dart';

class VacantRooms extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final hasTv;

  VacantRooms({
    @required this.startTime,
    @required this.endTime,
    this.hasTv = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVacantRooms(
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
        hasTv: hasTv,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List rooms = snapshot.data;
          return _buildBody(rooms);
        }
        if (snapshot.hasError) {
          return _buildErrorMessage(context, snapshot);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _buildBody(List rooms) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final Map room = rooms[index];
        final description = room["description"];
        final subtitle = description != null && description != ""
            ? description
            : room["location"];
        return ListTile(
            title: Text("${room["title"]}"),
            subtitle: Text(subtitle),
            leading: Icon(
              Icons.tv,
              color: room["hasTv"] ? Colors.lightGreen : Colors.redAccent,
            ));
      },
    );
  }

  _buildErrorMessage(context, AsyncSnapshot snapshot) {
    final mTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "${snapshot.error}",
          style: TextStyle(
            fontSize: 18.0,
            color: mTheme.errorColor,
          ),
        ),
      ),
    );
  }
}
