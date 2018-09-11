import 'package:flutter/material.dart';

class VacantRooms extends StatelessWidget {
  final List rooms;

  VacantRooms({@required this.rooms});

  @override
  Widget build(BuildContext context) {
    return _buildBody(rooms);
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
}
