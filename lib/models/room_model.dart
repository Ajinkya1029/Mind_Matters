class Room{
  Room({required this.roomId,required this.roomName,required this.owner,required this.picture,required this.postedat,required this.likes});
  final String roomId;
  final String roomName;
  final String owner;
  final String picture;
  final DateTime postedat;
   int likes;
}