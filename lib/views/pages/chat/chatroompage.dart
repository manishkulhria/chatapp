import 'package:chat_app/controller/authcontroller.dart';
import 'package:chat_app/controller/chatcontroller.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/model/authmodel.dart';
import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Chatroompage extends StatefulWidget {
  Usermodel model;

  Chatroompage({super.key, required this.model});

  @override
  State<Chatroompage> createState() => _ChatroompageState();
}

class _ChatroompageState extends State<Chatroompage> {
  TextEditingController _controller = TextEditingController();
  final _database = database();

 final chatdata="";
  ChatUser? currentuser, otheruser;
  @override
  void initState() {
    super.initState();
    final _usercontroller = Get.find<UserController>();
    currentuser = ChatUser(
        id: _usercontroller.user.uid!,
        firstName: _usercontroller.user.username);
    otheruser =
        ChatUser(id: widget.model.uid!, firstName: widget.model.username);

  }

  status() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(children: [
              Text(widget.model.username.toString()),
              Text(widget.model.status == false ? "" : "Online",
                  style: appstyle.textthme.fs12_semibold.copyWith(
                      color: widget.model.status == "Online"
                          ? appstyle.appcolors.whitecolor
                          : null))
            ]),
            backgroundColor: appstyle.appcolors.blue,
            foregroundColor: appstyle.appcolors.whitecolor),
        body: Column(children: [
          Expanded(
              child: StreamBuilder(
                  stream: _database.getchatdata(currentuser!.id, otheruser!.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    Chat? chat = snapshot.data?.data();
                    List<ChatMessage> messages = chat != null
                        ? _generateChatMessagesList(chat.messages)
                        : [];

                    return SafeArea(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DashChat(
                                messageOptions: const MessageOptions(
                                    showOtherUsersAvatar: true, showTime: true),
                                inputOptions:
                                    InputOptions(alwaysShowSend: true),
                                currentUser: currentuser!,
                                onSend: sendmessage,
                                messages: messages)));
                  }))
        ]));
  }

  // -------SEND MESSAGE-----
  Future<void> sendmessage(ChatMessage chatmsg) async {
    Message _msg = Message(
        senderID: currentuser!.id,
        content: chatmsg.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatmsg.createdAt));
    await _database.sendmsg(currentuser!.id, otheruser!.id, _msg);
  }

  // --------GENERATE CHAT MESSSAGE LIST--

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((msg) {
      return ChatMessage(
          user: msg.senderID == currentuser!.id ? currentuser! : otheruser!,
          text: msg.content ?? '',
          createdAt: msg.sentAt?.toDate() ?? DateTime.now());
    }).toList();

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return chatMessages;
  }
}
