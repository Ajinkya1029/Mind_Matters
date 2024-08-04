import 'package:mind_matters/models/room_model.dart';
class Thread{
  Thread({required this.ThreadId,required this.UserId,required this.ParentId,required this.Value,required this.children,required this.RoomId,required this.Likes,required this.OwnerName,required this.OwnerPp,required this.createdAt,required this.updatedAt});
  final String ThreadId;
  final String UserId;
   final String ?ParentId ;
   final String Value;
   final List<Thread>? children;
   final String RoomId;
   int Likes;
   final String OwnerName;
   final String OwnerPp;
   final String createdAt;
   final String updatedAt;

   

   factory Thread.fromJson(Map<String,dynamic>json){
  

 
  
    return Thread(
      ThreadId: json['_id'],
    UserId: json['UserId']??'',
  ParentId: json['ParentId']??'',
      Value: json['Value']?? '',
RoomId: json['RoomId'],
Likes:json['Likes']??'' ,
OwnerName: json['OwnerName']??'',
OwnerPp: json['OwnerPP']??'',
createdAt:json['createdAt']??'',
updatedAt: json['updatedAt']??'',
      children: (json['children'] as List<dynamic>?)
          ?.map((subJson) => Thread.fromJson(subJson))
          .toList(),
   
      );
      
   }
   
}











// UserId: "1233",
//   ParentId: "12312",
//       Value: "12342"?? '',
// RoomId: "123124",
// Likes:1 ,
// createdAt:"aasda"??'',
// updatedAt: "ASda"??'',
//       children: [],