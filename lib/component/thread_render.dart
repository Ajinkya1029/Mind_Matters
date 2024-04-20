import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/thread_model.dart';

class ThreadRender extends StatefulWidget {
  ThreadRender(this.thread, this.indent, {super.key});
  final Thread thread;
  final double indent;

  @override
  State<ThreadRender> createState() => _ThreadRenderState();
}

class _ThreadRenderState extends State<ThreadRender> {
  bool _isExpanded=true;
  static const double indentation = 2;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry pad =
        EdgeInsets.only(left: widget.indent* indentation);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: pad,child: Container(
          height: 50,
          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          color: Theme.of(context).colorScheme.secondary,
          width: double.infinity,
          child: Text(widget.thread.title),
        ),),
       if(widget.thread.subThread!.length>2)
       GestureDetector(onTap: (){
        setState(() {
          _isExpanded=!_isExpanded;
        });
       },child: Icon(Icons.add),),
       
       

       
       
        if(_isExpanded&&widget.thread.subThread!.isNotEmpty)
             ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.thread.subThread!.length,
                itemBuilder: (ctx, index) {
                  return ThreadRender(
                      widget.thread.subThread![index], widget.indent + 2);
                })
             
                   ],
    );
  }
}
