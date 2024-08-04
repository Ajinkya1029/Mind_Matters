import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mind_matters/models/room_model.dart';
import 'package:mind_matters/component/room_item.dart';
import 'package:mind_matters/component/thread_render.dart';
import 'package:mind_matters/models/thread_model.dart';
import 'package:mind_matters/utility/snackbar.dart';
import 'package:mind_matters/data/threadP_dummydata.dart';

class ThreadScreen extends StatefulWidget {
  ThreadScreen(this.room, this.showThread, this.likePost, {super.key});
  final Room room;
  final Function showThread;
  final Function likePost;

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  late Future<List<Thread>> _threadFuture;
  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? ParentId = null;
  bool canPop = true;

  @override
  void initState() {
    super.initState();
    _threadFuture = fetchData();
    _focusNode.addListener(_handleFocusChange);
  }

  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      canPop = !_focusNode.hasFocus;
    });
  }

  Future<void> _replyThread(Thread thread) async {
    setState(() {
      ParentId = thread.ThreadId;
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  Future<List<Thread>> fetchData() async {
    final response = await http.get(
        Uri.parse(
            "http://mind-matters-tb.us-east-1.elasticbeanstalk.com/threads/getThread?id=${widget.room.roomId}"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          'Authorization':
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjJlNGQ4NDU1NTdmZTMwY2JiODI1MDQiLCJ0eXBlIjoiTGF5bWVuIiwiaWF0IjoxNzE0NzM5MTMxLCJleHAiOjE3MTUzNDM5MzF9.otvVLrFlsp_vCPJiXAk2hI4UP03cNUl6AgLX6y_szL0"
        });
    if (response.statusCode == 200) {
      print(response.statusCode);
      List<Map<String, Object?>> data = json
          .decode(response.body)
          .map<Map<String, Object?>>(
              (element) => element as Map<String, Object?>)
          .toList();

      List<Thread> thread = data.map((e) => Thread.fromJson(e)).toList();
      return thread;
    } else {
       print(response.statusCode);
      throw Exception("Error: Failed to load Thread");
    }
  
  }

  Future<void> _addThread(String text) async {
    final response = await http.post(
        Uri.parse(
            "http://mind-matters-tb.us-east-1.elasticbeanstalk.com/threads/addThread"),
        headers: <String, String>{
          'Content-Type': "application/json;charset=UTF-8",
          'Authorization':
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjJlNGQ4NDU1NTdmZTMwY2JiODI1MDQiLCJ0eXBlIjoiTGF5bWVuIiwiaWF0IjoxNzE0NzM5MTMxLCJleHAiOjE3MTUzNDM5MzF9.otvVLrFlsp_vCPJiXAk2hI4UP03cNUl6AgLX6y_szL0"
        },
        body: jsonEncode({
          'Value': text,
          'ParentId': ParentId,
          'RoomId': widget.room.roomId
        }));
    if (response.statusCode == 200) {
      SnackbarUtils.showSnackBar("Comment Added");
    } else {
      SnackbarUtils.showSnackBar("Failed to Save");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (canPop) return;
        if (_focusNode.hasFocus) {
          setState(() {
            _focusNode.unfocus();
            ParentId = "";
            canPop = true;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mind Matter",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Thread>>(
                future: _threadFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Network Issue"),
                    );
                  } else {
                    List<Thread> thread = snapshot.data?? [];
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (ctx, index) {
                        if (index == 0) {
                          return RoomItem(widget.room, widget.showThread, false,
                              widget.likePost);
                        }
                        return ThreadRender(
                            thread[index - 1], 1, 0, index - 1, _replyThread);
                      },
                      itemCount: thread.length + 1,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(1),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  labelText: 'Add Comment',
                  labelStyle: const TextStyle(color: Colors.black),
                ),
                onSubmitted: _addThread,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
