import 'package:chat_app/model/authmodel.dart';

abstract class Authentication {
  Future<Usermodel> login({required String email, required String password});
  Future<Usermodel> signup({required Usermodel user, required String password});
}

// -----------

String generatechatid({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatid = uids.fold("", (id, uid) => "$id$uid");
  return chatid; 
}


// ----
