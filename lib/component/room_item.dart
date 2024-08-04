import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_matters/models/room_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';

class RoomItem extends StatefulWidget {
  RoomItem(this.room, this.showThread, this.isClick, this.likePost,
      {super.key});
  final Room room;
  final Function showThread;
  final bool isClick;
  final Function likePost;

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
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            widget.room.ThumbNail,
                            loadingBuilder: ((context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                  height: 280,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                  ),
                                );
                              }
                            }),
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 280,
                              child: const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            "${widget.room.RoomName}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(""),
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
                                  setState(() {
                                    if (widget.room.IsUpVote == true) {
                                      widget.room.UpVotes -= 1;
                                      widget.room.IsUpVote = false;
                                      //api call 3
                                      widget.likePost(widget.room, 3);
                                    } else if (widget.room.IsUpVote == false &&
                                        widget.room.IsDownVote == false) {
                                      widget.room.UpVotes += 1;
                                      widget.room.IsUpVote = true;
                                      //api call 1
                                      widget.likePost(widget.room, 1);
                                    } else if (widget.room.IsDownVote == true) {
                                      widget.room.DownVotes -= 1;
                                      widget.room.IsDownVote = false;
                                      widget.room.IsUpVote = true;
                                      widget.room.UpVotes += 1;
                                      //api call 5
                                      widget.likePost(widget.room, 5);
                                    }
                                  });
                                },
                                child: widget.room.IsUpVote == true
                                    ? Icon(
                                        Icons.arrow_upward_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      )
                                    : const Icon(Icons.arrow_upward_outlined)),
                            Text("${widget.room.UpVotes}"),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.room.IsDownVote == true) {
                                      widget.room.DownVotes -= 1;
                                      widget.room.IsDownVote = false;
                                      //api call 4
                                      widget.likePost(widget.room, 4);
                                    } else if (widget.room.IsUpVote == false &&
                                        widget.room.IsDownVote == false) {
                                      widget.room.DownVotes += 1;
                                      widget.room.IsDownVote = true;
                                      //api call 2
                                      widget.likePost(widget.room, 2);
                                    } else if (widget.room.IsUpVote == true) {
                                      widget.room.DownVotes += 1;
                                      widget.room.IsUpVote = false;
                                      widget.room.IsDownVote = true;
                                      widget.room.UpVotes -= 1;
                                      //api call 6
                                      widget.likePost(widget.room, 6);
                                    }
                                  });
                                },
                                child: widget.room.IsDownVote == true
                                    ? Icon(Icons.arrow_downward,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)
                                    : const Icon(Icons.arrow_downward)),
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
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  if (widget.isClick)
                                    widget.showThread(widget.room);
                                },
                                child: Icon(Icons.comment)),
                            Text("${widget.room.comment}")
                          ],
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
