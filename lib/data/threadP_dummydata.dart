import 'package:mind_matters/models/thread_model.dart';
// import 'package:mind_matters/models/room_model.dart';
import 'package:mind_matters/data/rooms_dummydata.dart';
 var dummythreadP=[Thread(ThreadId:"1", UserId: "123", ParentId: "12312", Value: "123214",OwnerName: "abc",OwnerPp: "abs", children: [
  Thread(ThreadId:"2",UserId: "123", ParentId: "12312", Value: "123214", OwnerName: "abc",OwnerPp: "abs",children: [Thread(ThreadId:"3",UserId: "123", ParentId: "12312", Value: "123214",OwnerName: "abc",OwnerPp: "abs", children: [], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314")], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314")
 ], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314"),Thread(ThreadId:"5",OwnerName: "abc",OwnerPp: "abs",UserId: "123", ParentId: "12312", Value: "123214", children: [
  Thread(ThreadId:"4",OwnerName: "abc",OwnerPp: "abs",UserId: "123", ParentId: "12312", Value: "123214", children: [Thread(ThreadId:"6",OwnerName: "abc",OwnerPp: "abs",UserId: "123", ParentId: "12312", Value: "123214", children: [], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314")], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314")
 ], RoomId: "1231", Likes: 2, createdAt: "12312", updatedAt:"12314")];
