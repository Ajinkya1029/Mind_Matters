import 'package:flutter/material.dart';
import 'package:mind_matters/models/thread_model.dart';
import 'package:mind_matters/component/comment_block.dart';

class ThreadRender extends StatefulWidget {
  ThreadRender(this.thread,  {super.key});
  final Thread thread;
  
  @override
  State<ThreadRender> createState() => _ThreadRenderState();
}

class _ThreadRenderState extends State<ThreadRender> {
  var _isExpanded = null;
  static const double indentation = 2;
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Comment(title: widget.thread.title, pad: 5),
        if (widget.thread.subThread!.isNotEmpty)
          CustomPaint(
            painter: LinePainter(indent: 5),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     Comment(title: widget.thread.subThread![index].title, pad: 5),
                      if (widget.thread.subThread![index].subThread!.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                          _isExpanded==null?_isExpanded = widget.thread.subThread![index].title:_isExpanded=null;
                            });
                          },
                          child: _isExpanded==widget.thread.subThread![index].title?Icon(Icons.remove):Icon(Icons.add),
                        ),
                      if (_isExpanded == widget.thread.subThread![index].title)
                        CustomPaint(
                          painter: LinePainter(indent: 5),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (ctx, id) =>  Comment(title: widget.thread.subThread![index].subThread![id].title, pad: 20),
                            itemCount:
                                widget.thread.subThread![index].subThread!.length,
                          ),
                        )
                    ],
                  )),
              itemCount: widget.thread.subThread?.length,
            ),
          )
      ],
    );
  }
}
class LinePainter extends CustomPainter {
  final double indent;


  LinePainter({
    required this.indent,
   
  
    
  });

  @override
  void paint(Canvas canvas, Size size) {
   
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1; 

double startX = 3+ indent.toDouble(); 
    double startY = 0;
    double endY = size.height;


    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), paint);
  

  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return false;
  }
}