import 'package:flutter/material.dart';
import 'package:mind_matters/component/add_post.dart';
import 'package:mind_matters/component/room_item.dart';

import 'package:mind_matters/data/rooms_dummydata.dart';
import 'package:mind_matters/screens/thread_screen.dart';
import 'package:mind_matters/models/room_model.dart';

class Rooms extends StatefulWidget {
  Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomState();
}

class _RoomState extends State<Rooms> {
  void addPostOverlay() {
    showModalBottomSheet(context: context, builder: (context) => AddPost());
  }
  void _showThread(Room room){
Navigator.push(context, MaterialPageRoute(builder: (context)=>ThreadScreen(room,_showThread)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (ctx, index) => RoomItem(thread[index],_showThread),
                  itemCount: thread.length,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        onPressed: addPostOverlay,
                        child: Icon(Icons.add),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
