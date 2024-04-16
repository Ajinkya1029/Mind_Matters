import 'package:mind_matters/models/room_model.dart';
class Thread{
  Thread({required this.parentRoom,required this.title,required this.subThread});
   final Room parentRoom ;
   final String title;
   final Thread? subThread;
   
}