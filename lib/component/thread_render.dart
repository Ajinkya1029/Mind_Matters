import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/component/comment_block.dart';
import 'package:mind_matters/models/thread_model.dart';

class ThreadRender extends StatefulWidget {
  ThreadRender(this.thread, this.indent,this.lev,this.call, {super.key});
  final Thread thread;
  final double indent;
  final double lev;
  final int call;

  @override
  State<ThreadRender> createState() => _ThreadRenderState();
}

class _ThreadRenderState extends State<ThreadRender> {
  

  static const double indentation = 2;

  @override
  Widget build(BuildContext context) {
  
     final  EdgeInsetsGeometry pad ;

if((widget.lev==0&&widget.call==0)) {
  
  
 pad=EdgeInsets.only(left: widget.indent+ indentation,top: 5,bottom: 5);
}   
else if(widget.lev==0&&widget.call!=0)   {
     pad=EdgeInsets.only(left: widget.indent+ indentation,top: 40,bottom: 5);
     }else{
      pad=EdgeInsets.only(left: widget.indent+ indentation,top: 5,bottom: 5);
     }

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       Comment(title: widget.thread.Value, pad: pad),
    
             
   
    
       widget.thread.children!.isNotEmpty?CustomPaint(painter: LinePainter(indent: widget.indent,height: widget.thread.children!.length.toDouble()*60,cont: widget.thread.Value),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.thread.children!.length,
                itemBuilder: (ctx, index) {
                  return ThreadRender(
                      widget.thread.children![index], widget.indent +15,widget.lev+1,widget.call+1);
  }),):Text(""),
        
        

          
      
       
       
           
                   ],
    
    );
  }
}
class LinePainter extends CustomPainter {
  final double indent;
  final double height;
 final String cont;

  LinePainter({
    required this.indent,
    required this.height,
    required this.cont
    
  });

  @override
  void paint(Canvas canvas, Size size) {
   
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1; 

double startX = 3+ indent.toDouble(); 
    double startY = 0;
    double endY = size.height;

double  noOfLines=size.height/height.ceil();
// print(noOfLines);

    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), paint);
  //   for(int i=0;i<noOfLines;i++){
  //  canvas.drawLine(Offset(startX,i*height+10), Offset(startX+5,i*height+10), paint);
  //   }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return false;
  }
}