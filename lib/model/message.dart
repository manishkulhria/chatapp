import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { Text, Image }

class Message {
  String? senderID;
  String? content;
  MessageType? messageType;
  Timestamp? sentAt;

  Message({
    required this.senderID,
    required this.content,
    required this.sentAt,
    required this.messageType,
  });

  Message.fromJson(Map<Object?, Object?> json)
      : senderID = json['senderID'].toString(),
        content = json['content'].toString(),
        sentAt = Timestamp.now(),
        messageType = _getMessageType(json['messageType'].toString());

  static MessageType _getMessageType(String? type) {
    if (type != null && MessageType.values.any((e) => e.name == type)) {
      return MessageType.values.byName(type);
    } else {
      return MessageType.Text;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'content': content,
      'sentAt': sentAt.toString(),
      "messageType": messageType?.name ?? 'Text'
    };
  }
}
