import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/room_model.dart';

class RoomItem extends StatefulWidget {
  RoomItem(this.room, this.showThread, this.isClick, {super.key});
  final Room room;
  final Function showThread;
  final bool isClick;

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  int isLikes = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          if (widget.isClick) {
            widget.showThread(widget.room);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                    widget.room.Owner,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
              Container(
                child: Text(widget.room.RoomName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: widget.room.ThumbNail.isNotEmpty
                    ? SizedBox(
                        height: 300,
                        width: double.maxFinite,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                
                                widget.room.ThumbNail,
                                semanticLabel: "Failed to load image",
                                height: 280,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "${widget.room.RoomName}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.maxFinite,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("HI"),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    print(isLikes);
                                    setState(() {
                                      if (isLikes == 1) {
                                        isLikes = 0;
                                        widget.room.UpVotes -= 1;
                                      } else if(isLikes==2) {
                                        isLikes = 1;
                                        widget.room.UpVotes += 1;
                                        widget.room.DownVotes-=1;
                                      }else{
                                         isLikes = 1;
                                          widget.room.UpVotes += 1;
                                      }
                                    });
                                  },
                                  child: isLikes==1?
                                      const Icon(Icons.arrow_upward_rounded)
                                      : const Icon(Icons.arrow_upward_outlined)),
                              Text("${widget.room.UpVotes}"),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isLikes == 2) {
                                        isLikes = 0;
                                        widget.room.DownVotes -= 1;
                                      } else if(isLikes==1) {
                                        isLikes = 2;
                                        widget.room.UpVotes-=1;
                                        widget.room.DownVotes += 1;
                                        
                                      }else{
                                        isLikes = 2;
                                        widget.room.DownVotes += 1;
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.arrow_downward))
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black)),
                      child:  Padding(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Row(
                            children: <Widget>[Icon(Icons.comment), Text("${widget.room.comment}")],
                          )),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black)),
                      child: const Padding(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Icon(Icons.share)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}