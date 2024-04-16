import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _postTextController = TextEditingController();

  @override
  void dispose(){
    _postTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height *0.5;
    return  Padding(
        
        padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          height: _screen_height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _postTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "Feeling Depressed Come on GROW UP!!",
                      border: UnderlineInputBorder()),
                ),
                const Spacer(),
                OutlinedButton(
                    onPressed: () {
                      // Post Request with _postTextController data to endpoint
                      Navigator.pop(context);
                    },
                    child: Text("Submit")),
              ]),
        ),
      );
  }
}
