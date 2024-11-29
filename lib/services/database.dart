import 'package:chat_app/backend/repo/auth_repo.dart';
import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class database {
  final _firebasefirestore = FirebaseFirestore.instance;
  CollectionReference? _chatcollection;

  database() {
    _setupcollection();
  }
  // ---------setup collection

  void _setupcollection() {
    _chatcollection = _firebasefirestore
        .collection("chats")
        .withConverter<Chat>(
            fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toMap());
  }

  String _getChatID(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort();
    return users.join('_');
  }

  // --------CHECK CHAT EXISTS-----
 
  Future<bool> checkchatexists(String uid1, String uid2) async {
    String chatid = generatechatid(uid1: uid1, uid2: uid2);
    final result = await _chatcollection?.doc(chatid).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  // --------NEW CHAT EXISTS-----

  Future<void> newchat(String uid1, String uid2) async {
    String chatid = generatechatid(uid1: uid1, uid2: uid2);
    final docref = _chatcollection?.doc(chatid);
    final chat = Chat(id: chatid, participants: [uid1, uid2], messages: []);
    await docref?.set(chat);
  }
  // --------send message ---
  Future<void> sendmsg(
      String senderID, String receiverID, Message message) async {
    String chatID = _getChatID(senderID, receiverID);

    DocumentReference chatDocRef =
        _firebasefirestore.collection('chats').doc(chatID);

    DocumentSnapshot chatSnapshot = await chatDocRef.get();

    if (!chatSnapshot.exists) {
      final newChat = Chat(
        id: chatID,
        participants: [senderID, receiverID],
        messages: [],
      );
      await chatDocRef.set(newChat.toMap());
    }
    await chatDocRef.update({
      'messages': FieldValue.arrayUnion([message.toMap()])
    });
  }

  // -----get chat data-----

  Stream<DocumentSnapshot<Chat>> getchatdata(String user1, String user2) {
    String chatID = _getChatID(user1, user2);
    return _firebasefirestore
        .collection('chats')
        .doc(chatID)
        .withConverter<Chat>(
            fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
            toFirestore: (chat, _) => chat.toMap())
        .snapshots();
  }
}
