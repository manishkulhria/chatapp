import 'package:chat_app/backend/Firebaseresponse/Firebaseresponse.dart';

class Usermodel {
  String? uid;
  String? email;
  String? username;
  bool? status;

  Usermodel({this.uid, this.email, this.username, this.status});

  Usermodel.fromJson(FirebaseResponseModel json, this.uid)
      : email = json.data["email"] ?? "",
        username = json.data["username"] ?? "",
        status = json.data["status"] ?? false;

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "username": username, "status": status};

  Usermodel copyWith(
      {String? uid, String? email, String? username, bool? status}) {
    return Usermodel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        username: username ?? this.username,
        status: status ?? this.status);
  }
}
