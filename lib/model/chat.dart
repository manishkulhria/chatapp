import 'package:chat_app/model/message.dart';

class Chat {
  String id;
  List<String> participants;
  List<Message> messages;

  Chat({required this.id, required this.participants, required this.messages});

  // Converts Firestore data to a Chat object
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['id'] as String,
        participants: List<String>.from(json['participants']),
        messages: (json['messages'] as List)
            .map((msg) => Message.fromJson(msg))
            .toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'messages': messages.map((msg) => msg.toMap()).toList(),
    };
  }
}
