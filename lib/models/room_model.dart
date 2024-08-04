
class Room {
  Room(
      {required this.roomId,
      required this.RoomName,
      required this.Owner,
      required this.ThumbNail,
      required this.createdAt,
      required this.updatedAt,
      required this.UpVotes,
      required this.DownVotes,
      required this.OwnerPP,
      required this.comment,
      required this.IsUpVote,
      required this.IsDownVote});
  final String roomId;
  final String RoomName;
  final String Owner;
  final String ThumbNail;
  final String createdAt;
  final String updatedAt;
  final String OwnerPP;
  bool IsUpVote;
  bool IsDownVote;
  int comment;
  int UpVotes;
  int DownVotes;

  factory Room.fromJson(Map<String,dynamic > json) {
   
    return Room(

        UpVotes: json['UpVotes']?? '',
        roomId: json['_id']?? '',
        Owner: json['ownerName']?? '',
        ThumbNail: json['ThumbNail']?? '',
        createdAt: json['createdAt']?? '',
        updatedAt: json['updatedAt']?? '',
        RoomName: json['RoomName']?? '',
        DownVotes: json['DownVotes']?? '',
        OwnerPP:  json['ownerPP']?? '',
        comment: json['commentsCount']?? '',
        IsUpVote: json['isUpvote']??false,
        IsDownVote: json['isDownVote']??false,
        );
  }
}
// Make owner as List of Sttring? 