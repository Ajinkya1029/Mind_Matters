import 'package:flutter/material.dart';
import 'package:mind_matters/models/room_model.dart';

class RoomItem extends StatefulWidget {
  RoomItem(this.room, this.showThread, {super.key});
  final Room room;
  final Function showThread;

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  int like = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        widget.showThread(widget.room);
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(1), spreadRadius: 0.5)
        ]),
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget.room.RoomName}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "${widget.room.Owner}",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )),
              widget.room.ThumbNail!.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      width: double.maxFinite,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "IMG",
                            style: Theme.of(context).textTheme.bodySmall,
                          )),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            like == 1 ? {like = 0,widget.room.UpVotes-=1} : {like = 1,widget.room.UpVotes+=1};
                            
                          });
                        },
                        child: like == 1
                            ? Column(
                                children: <Widget>[
                                  const Expanded(child:  Icon(Icons.thumb_up)),
                                  Text("${widget.room.UpVotes}")
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  const Expanded(
                                      child:  Icon(
                                          Icons.thumb_up_alt_outlined)),
                                  Text("${widget.room.UpVotes}")
                                ],
                              ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            like == 2 ? {like = 0,widget.room.DownVotes-=1 }: {like = 2,widget.room.DownVotes+=1};
                          });
                        },
                        child: like == 2
                            ? Column(
                                children: <Widget>[
                                  const Expanded(child:  Icon(Icons.thumb_down)),
                                  Text("${widget.room.DownVotes}")
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  const Expanded(
                                    child:
                                        Icon(Icons.thumb_down_outlined),
                                  ),
                                  Text("${widget.room.DownVotes}")
                                ],
                              ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.share),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
  
  //                           : 