import 'package:flutter/material.dart';
class Comment extends StatefulWidget{
  Comment({required this.title,required this.pad,super.key});
  final String title;
  final EdgeInsetsGeometry pad;
  @override
  State<Comment> createState()=>_CommentState();

}
class _CommentState extends State<Comment>{
  @override
  Widget build(BuildContext context){
    return Padding(
            padding: widget.pad,
            child: Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              color: Theme.of(context).colorScheme.secondary,
              width: double.infinity,
              child: Text(widget.title),
            ));
  }
}