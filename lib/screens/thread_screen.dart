import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/room_model.dart';
import 'package:mind_matters/component/room_item.dart';
import 'package:mind_matters/data/threadP_dummydata.dart';
import 'package:mind_matters/component/thread_render.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mind_matters/models/thread_model.dart';
import 'package:mind_matters/data/thread_data.dart';

class ThreadScreen extends StatefulWidget {
  ThreadScreen(this.room, this.showThread, {super.key});
  final Room room;
  final Function showThread;
  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  
  late Future<List<Thread>>_threadFuture;
  void initState() {
    super.initState();
   
    _threadFuture=fetchData();
  }
Future<List<Thread>> fetchData ()async{

      final response = await http.get(
          Uri.parse(
             "http://taher-basrai-mind-matters.us-east-1.elasticbeanstalk.com/threads/getThread?id=${widget.room.roomId}"),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
            'Authorization':
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjJlNGQ4NDU1NTdmZTMwY2JiODI1MDQiLCJ0eXBlIjoiTGF5bWVuIiwiaWF0IjoxNzE0NzM5MTMxLCJleHAiOjE3MTUzNDM5MzF9.otvVLrFlsp_vCPJiXAk2hI4UP03cNUl6AgLX6y_szL0"
          });
if(response.statusCode==200){
  List<Map<String,Object?>>data=json.decode(response.body).map<Map<String,Object?>>((element)=>element as Map<String,Object?>).toList();
  print(data);
  List<Thread>thread=data.map((e) => Thread.fromJson(e)).toList();
  return thread;
}else{
  throw Exception("Error: Failed to load Thread");
}



}
  

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RoomItem(widget.room, widget.showThread,false),

             FutureBuilder<List<Thread>>(future:_threadFuture , builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return SnackBar(content: Center(child: Text("Network Issue"),));
              }else{
                List<Thread>thread=snapshot.data!;
                return Padding(padding: EdgeInsets.all(10),child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) =>
                              ThreadRender(thread[index], 1, 0, index),
                          itemCount: thread.length,
                        ),);
              }
             })
          
            ],
          ),
        ));
  }
}
