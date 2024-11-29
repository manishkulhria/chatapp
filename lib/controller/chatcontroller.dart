import 'package:chat_app/controller/authcontroller.dart';
import 'package:chat_app/model/chatmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatcontroller extends GetxController {
  // final _firebasedatabase = FirebaseDatabase.instance;
  // Future sendchat(Chatmodel data, String userid, String otherid) async {
  //   try {
  //     await _firebasedatabase
  //         .ref("chat")
  //         .child("$userid $otherid")
  //         .push()
  //         .set(data.tomap());
  //   } catch (e) {
  //     print("===================");
  //     print(e.toString());
  //     print("===================");
  //     print("------------");
  //   }
  // }
  final _firebasedatabase = FirebaseDatabase.instance;
  Future sendchat(String chatid, TextEditingController controller) async {
    try {
      await _firebasedatabase.ref("chat${chatid}message").push().set(Chatmodel(
          read: false,
          text: controller.text,
          time: DateTime.now(),
          senderid: UserController().user.uid));
    } catch (e) {
      print("===================");
      print(e.toString());
      print("===================");
      print("------------");
    }
  }
}
