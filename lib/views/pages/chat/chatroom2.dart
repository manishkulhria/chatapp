// import 'package:chat_app/main.dart';
// import 'package:chat_app/model/authmodel.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Chatroompage2 extends StatefulWidget {
//   Usermodel model;

//   Chatroompage2({super.key, required this.model});

//   @override
//   State<Chatroompage2> createState() => _Chatroompage2State();
// }

// class _Chatroompage2State extends State<Chatroompage2> {
//   TextEditingController _controller = TextEditingController();
// //   final _database = database();

// //  late Future<dynamic> chatdata;
// //   ChatUser? currentuser, otheruser;
// //   @override
// //   void initState() {
// //     super.initState();
// //     final _usercontroller = Get.find<UserController>();
// //     currentuser = ChatUser(
// //         id: _usercontroller.user.uid!,
// //         firstName: _usercontroller.user.username);
// //     otheruser =
// //         ChatUser(id: widget.model.uid!, firstName: widget.model.username);

// //    chatdata=  Chatcontroller().sendchat(currentuser!.id, _controller);
// //   }

// //   status() {}

// late DatabaseReference _ref = FirebaseDatabase.instance.ref().child("message");


// @override
//   void initState() {
//     // TODO: implement initState
//     _ref =FirebaseDatabase.instance.ref("chats/${widget.model.uid}/messages");  }

//     Future _sendmessage() async{
//       final message = _controller.text.trim();

//     }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//         appBar: AppBar(
//             title: Column(children: [
//               Text(widget.model.username.toString()),
//               Text(widget.model.status == false ? "" : "Online",
//                   style: appstyle.textthme.fs12_semibold.copyWith(
//                       color: widget.model.status == "Online"
//                           ? appstyle.appcolors.whitecolor
//                           : null))
//             ]),
//             backgroundColor: appstyle.appcolors.blue,
//             foregroundColor: appstyle.appcolors.whitecolor),
//         body: Column(children: [
//           Expanded(
//               child: StreamBuilder(
//                   stream: chatdata.data(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     // Chat? chat = snapshot.data?.data();
//                     // List<ChatMessage> messages = chat != null
//                     //     ? _generateChatMessagesList(chat.messages)
//                     //     : [];

//                     return SafeArea(
//                         child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: DashChat(
//                                 messageOptions: const MessageOptions(
//                                     showOtherUsersAvatar: true, showTime: true),
//                                 inputOptions:
//                                     InputOptions(alwaysShowSend: true),
//                                 currentUser: currentuser!,
//                                 onSend: sendmessage,
//                                 messages: messages)));
//                   }))
//         ]));
//   }

//   // -------SEND MESSAGE-----
//   // Future<void> sendmessage(ChatMessage chatmsg) async {
//   //   Message _msg = Message(
//   //       senderID: currentuser!.id,
//   //       content: chatmsg.text,
//   //       messageType: MessageType.Text,
//   //       sentAt: Timestamp.fromDate(chatmsg.createdAt));
//   //   await _database.sendmsg(currentuser!.id, otheruser!.id, _msg);
//   // }

//   // --------GENERATE CHAT MESSSAGE LIST--

//   // List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
//   //   List<ChatMessage> chatMessages = messages.map((msg) {
//   //     return ChatMessage(
//   //         user: msg.senderID == currentuser!.id ? currentuser! : otheruser!,
//   //         text: msg.content ?? '',
//   //         createdAt: msg.sentAt?.toDate() ?? DateTime.now());
//   //   }).toList();

//   //   chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//   //   return chatMessages;
//   // }
// }
