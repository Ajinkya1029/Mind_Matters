import 'package:flutter/material.dart';
import 'package:mind_matters/models/room_model.dart';

class RoomItem extends StatelessWidget {
  RoomItem(this.room, {super.key});
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(1),spreadRadius: 0.5)]),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      padding: EdgeInsets.fromLTRB(15, 8, 8, 15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${room.roomName}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "${room.owner}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )),
            Container(child: Text("${room.picture}")),
            Container(
                child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up_outlined),
                SizedBox(width: 20),
                Icon(Icons.thumb_down_outlined)
              ],
            ))
          ]),
    );
  }
}
