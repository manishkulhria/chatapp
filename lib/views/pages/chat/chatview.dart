// import 'package:chat_app/controller/authcontroller.dart';
// import 'package:chat_app/controller/chatcontroller.dart';
// import 'package:chat_app/main.dart';
// import 'package:chat_app/model/authmodel.dart';
// import 'package:chat_app/model/chatmodel.dart';
// import 'package:chat_app/model/message.dart';
// import 'package:chat_app/views/components/Textfield/Textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class Chatview extends StatefulWidget {
//   Usermodel model;

//   Chatview({super.key, required this.model});

//   @override
//   State<Chatview> createState() => _ChatviewState();
// }

// class _ChatviewState extends State<Chatview> {
//   final _usercontroller = Get.find<UserController>();
//   TextEditingController _controller = TextEditingController();

//   ChatUser? currentuser, otheruser;
//   void initState() {
//     super.initState();
//     currentuser = ChatUser(
//         id: _usercontroller.user.uid!,
//         firstName: _usercontroller.user.username);
//     otheruser =
//         ChatUser(id: widget.model.uid!, firstName: widget.model.username);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _db = FirebaseDatabase.instance
//         .ref("chat")
//         .child("${currentuser!.id} ${otheruser!.id}");

//     print(_usercontroller.user.uid);
//     return Scaffold(
//         bottomSheet: Row(children: [
//           Expanded(child: Textfieldwidget(controller: _controller)),
//           IconButton(
//               onPressed: () async {
//                 final msg = Chatmodel(
//                     read: false,
//                     senderid: _usercontroller.user.uid,
//                     text: _controller.text,
//                     time: DateTime.now(),
//                     type: Chattype.Text);

//                 await Chatcontroller()
//                     .sendchat(msg, currentuser!.id, otheruser!.id);
//                 _controller.clear();
//               },
//               icon: Icon(Icons.send))
//         ]),
//         appBar: AppBar(
//             title: Text(widget.model.username.toString()),
//             backgroundColor: appstyle.appcolors.blue,
//             foregroundColor: appstyle.appcolors.whitecolor),
//         body: Column(children: [
//           FirebaseAnimatedList(
//               shrinkWrap: true,
//               query: _db,
//               itemBuilder: (context, snapshot, animation, index) {
//                 final data =
//                     Chatmodel.fromjson(snapshot.value as Map<Object?, Object?>);

//                 return Text(data.text ?? "");
//               })
//         ]));
//   }

//   //  -------SEND MESSAGE-----
//   // Future<void> sendmessage(String chatmsg) async {
//   //   Message _msg = Message(
//   //       senderID: currentuser!.id,
//   //       content: chatmsg,
//   //       messageType: MessageType.Text,
//   //       sentAt: Timestamp.now());
//   //   await Chatcontroller().sendchat(_msg as Chatmodel);
//   // }

//   Future<void> sendmessage(ChatMessage chatdata) async {
//     final _msg = Message(
//         senderID: currentuser!.id,
//         content: chatdata.text,
//         sentAt: Timestamp.fromDate(chatdata.createdAt),
//         messageType: MessageType.Text);
//     await Chatcontroller()
//         .sendchat(_msg as Chatmodel, currentuser!.id, otheruser!.id);
//   }
// }
