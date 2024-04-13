import 'package:flutter/material.dart';
import 'package:mind_matters/component/room_item.dart';

import 'package:mind_matters/data/thread_dummydata.dart';

class Rooms extends StatefulWidget {
  Rooms({super.key});
  @override
  State<Rooms> createState() => _RoomState();
}

class _RoomState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (ctx, index) => RoomItem(thread[index]),
                  itemCount: thread.length,
                ),
                Positioned(
                      bottom: 16,
                      right: 16,
                    child: Padding(
                    padding: EdgeInsets.all(20),
                      child: FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        onPressed: () {},
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
