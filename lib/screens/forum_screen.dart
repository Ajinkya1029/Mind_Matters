import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mind_matters/component/add_post.dart';
import 'package:mind_matters/component/room_item.dart';

import 'package:mind_matters/data/rooms_dummydata.dart';
import 'package:mind_matters/screens/thread_screen.dart';
import 'package:mind_matters/models/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Rooms extends StatefulWidget {
  Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomState();
}

class _RoomState extends State<Rooms> {
  late Future<List<Room>>_roomFuture;
  void initState() {
    super.initState();
    _roomFuture=fetchData();
  }

  Future<List<Room>> fetchData() async {

  
     final response = await http.get(Uri.parse("http://mindmattersapp-env-2.eba-rhfxjbmn.us-east-1.elasticbeanstalk.com/rooms/getAll"), headers: <String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': "Token"
  });
    if(response.statusCode==200){
      List<dynamic>data=json.decode(response.body);
 List<Room>room=data.map((e) => Room.fromJson(e)).toList();
return room;
     

    }else{
      throw Exception('Failed to load Rooms');
    }
   
}
  

  void addPostOverlay() {
    showModalBottomSheet(context: context, builder: (context) => AddPost());
  }

  void _showThread(Room room) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ThreadScreen(room, _showThread)));
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
               FutureBuilder(future: _roomFuture, builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else if(snapshot.hasError){
                  return Center(child: Text("Error: ${snapshot.error}"),);
                }else{
                  List<Room>room=snapshot.data!;
                  return ListView.builder(
                  itemBuilder: (ctx, index) =>
                      RoomItem(room![index], _showThread),
                  itemCount: room.length,
                );
                }
               }),
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
