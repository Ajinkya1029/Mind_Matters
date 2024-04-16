import 'package:flutter/material.dart';
import 'package:mind_matters/models/room_model.dart';
import 'package:mind_matters/component/room_item.dart';

class ThreadScreen extends StatefulWidget {
  ThreadScreen(this.room,this.showThread ,{super.key});
   final Room room;
   final Function showThread;
  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mind Matter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: <Widget>[RoomItem(widget.room, widget.showThread),Container(child: Text("Comments"),)],)
    );
  }
}
