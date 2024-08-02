import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/thread_model.dart';

class Comment extends StatefulWidget {
  Comment({required this.thread, required this.pad,required this.replyThread,super.key});
  final Thread thread;
  final EdgeInsetsGeometry pad;
  final Future<void>Function(Thread) replyThread;
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
           Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                onPressed: (){widget.replyThread(widget.thread);},
                icon: const Icon(
                  Icons.reply,color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_upward_outlined),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_downward),
            ],
          ),
        ],
      ),
    );
  }
}
