
enum Chattype { Text, Image }

class Chatmodel {
  String? senderid;
  String? text;
  Chattype? type;
  DateTime? time;
  bool? read;

  Chatmodel({this.senderid, this.time, this.read, this.text, this.type});

  // ----to map--

  Map<String, dynamic> tomap() {
    return {
      "text": text ?? "",
      "type": type?.name ?? 'Text',
      "read": read ?? false,
      "time": time.toString(),
    };
  }

// -----
  Chatmodel.fromjson(Map<Object?, Object?> json)
      : senderid = json["senderid"].toString(),
        text = json["text"].toString(),
        type = _getChattype(json['type'].toString()),
        time = DateTime.parse(json["time"].toString()),
        read = (json["read"] ?? false) as bool;

  static Chattype _getChattype(String? chattype) {
    if (chattype != null && Chattype.values.any((e) => e.name == chattype)) {
      return Chattype.values.byName(chattype);
    } else {
      return Chattype.Text;
    }
  }
}
