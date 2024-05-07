import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/thread_model.dart';

class Comment extends StatefulWidget {
  Comment({required this.thread, required this.pad, super.key});
  final Thread thread;
  final EdgeInsetsGeometry pad;
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.account_circle),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.thread.UserId,
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 2, 0, 0),
            child: Text(widget.thread.Value),
          ),
          const Row(children: <Widget>[
            Spacer(),
            Icon(Icons.reply),
            SizedBox(width: 10,),
            Icon(Icons.arrow_upward_outlined),
             SizedBox(width: 10,),
            Icon(Icons.arrow_downward),
          ],),
        ],
      ),
      
    );
  }
}
