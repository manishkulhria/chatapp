class Chatroommodel {
  String? chatroomid;
  List<String>? participant;
  Chatroommodel({this.chatroomid, this.participant});
  Chatroommodel.fromjson(Map<String, dynamic> json)
      : chatroomid = json["chatroomid"],
        participant = json["participant"];

  Map<String, dynamic> tomap() {
    return {"chatroomid": chatroomid, "participant": participant};
  }
}
