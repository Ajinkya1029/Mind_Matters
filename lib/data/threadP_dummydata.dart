import 'package:mind_matters/models/thread_model.dart';
import 'package:mind_matters/models/room_model.dart';
import 'package:mind_matters/data/rooms_dummydata.dart';

var dummythreadP = [
  Thread(parentRoom: thread[0], title: "Micheal Myers Broken", subThread: [
    Thread(parentRoom: thread[0], title: "Plague is broken", subThread: [
      Thread(parentRoom: thread[0], title: "Yeah right", subThread: []),
      Thread(parentRoom: thread[0], title: "Yeah right", subThread: []),
      Thread(parentRoom: thread[0], title: "Yeah right", subThread: [])
    ]),
    Thread(parentRoom: thread[0],  title: "Free id for sale", subThread: []),
Thread(parentRoom: thread[0], title: "Micheal Myers Broken", subThread: [
    Thread(parentRoom: thread[0], title: "Plague is broken", subThread: [
      Thread(parentRoom: thread[0], title: "Yeah right", subThread: [])
    ])]),
  ]),
  Thread(parentRoom: thread[0], title: "How to get free survivirs", subThread: [
    Thread(parentRoom: thread[0], title: "Get Better", subThread: [
      Thread(parentRoom: thread[0], title: "Arghh", subThread: [])
    ])
  ]),
  Thread(
      parentRoom: thread[1], title: "How to get free survivirs", subThread: []),
  Thread(
      parentRoom: thread[1], title: "How to get free survivirs", subThread: []),
];
