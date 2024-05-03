
class Room {
  Room(
      {required this.roomId,
      required this.RoomName,
      required this.Owner,
      required this.ThumbNail,
      required this.createdAt,
      required this.updatedAt,
      required this.UpVotes,
      required this.DownVotes});
  final String roomId;
  final String RoomName;
  final String Owner;
  final String ThumbNail;
  final String createdAt;
  final String updatedAt;
 int UpVotes;
  int DownVotes;

  factory Room.fromJson(Map<String,dynamic > json) {
   
    return Room(

        UpVotes: json['UpVotes']?? '',
        roomId: json['_id']?? '',
        Owner: json['Owner']?? '',
        ThumbNail: json['ThumbNail']?? '',
        createdAt: json['createdAt']?? '',
        updatedAt: json['updatedAt']?? '',
        RoomName: json['RoomName']?? '',
        DownVotes: json['DownVotes']?? '');
  }
}
