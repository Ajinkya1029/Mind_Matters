import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  ScrollController _scrollController = ScrollController();
  late Future<List<Room>> _roomFuture;
  List<Room> _rooms = [];
  bool _isLoading = false;

  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _roomFuture = fetchData();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<Room>> fetchData() async {

  try{
      final response = await http.get(
        Uri.parse(
            "http://taher-basrai-mind-matters.us-east-1.elasticbeanstalk.com/rooms/getAll?skip=${_rooms.length}"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': "Token"
        });
    if (response.statusCode == 200) {
      
      List<dynamic> data = json.decode(response.body);
      List<Room> room = data.map((e) => Room.fromJson(e)).toList();
      return room;
    } else {
      
      throw Exception('Failed to load Rooms');
    }
  }catch(err){
    List<Room>data=[];
 
    _showSnackBar(context);
    return data;
   
  }
  }
void _showSnackBar(BuildContext context){
  if(mounted){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.secondary,content: Text("Network Error")));
  
  }
}
  Future<void> appendData() async {
   
    setState(() {
      _isLoading = true;
    });
    final additionalData = await fetchData();
    if(additionalData!=""){
    setState(() {
      _rooms.addAll(additionalData);
      _isLoading = false;
    });
    }
    else{
     _showSnackBar(context);
    }
  }

  void _scrollListener() {
   
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      appendData();
    }
  }

  void addPostOverlay() {
    showModalBottomSheet(isScrollControlled:  true,context: context, builder: (context) => AddPost());
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
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: Stack(children: <Widget>[
                FutureBuilder(
                    future: _roomFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return SnackBar(content: Center(child: Text("Network Issue"),));
                        
                      } else {
                        _rooms = snapshot.data!;
                        
                        return ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (ctx, index) =>
                              RoomItem(_rooms[index], _showThread, true),
                          itemCount: _rooms.length,
                        );
                      }
                    }),
                // ListView.builder(
                //           controller: _scrollController,
                //           itemBuilder: (ctx, index) =>
                //               RoomItem(thread[index], _showThread, true),
                //           itemCount: thread.length,
                //         ),
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
                        ))),
              ]))
            ]));

    // ],
    // ),
    // );
  }
}
