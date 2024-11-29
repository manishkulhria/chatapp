import 'package:chat_app/backend/Apis/Apis.dart';
import 'package:chat_app/backend/Exception/AppExceptions.dart';
import 'package:chat_app/backend/Firebaseresponse/Firebaseresponse.dart';
import 'package:chat_app/backend/repo/Sharepref.dart';
import 'package:chat_app/backend/repo/auth_repo.dart';
import 'package:chat_app/controller/authcontroller.dart';
import 'package:chat_app/model/authmodel.dart';
import 'package:chat_app/resource/config/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepositry extends Authentication {
  final _auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  @override
  Future<Usermodel> login(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final doc = await Apis.userDocumentRef(credential.user!.uid).get();

      if (doc.exists) {
        final userData =
            Usermodel.fromJson(FirebaseResponseModel.fromResponse(doc), doc.id);
        await SpData.setprafdata(SpData.userid, doc.id);
        return userData;
      } else {
        throw DefaultException(message: "User not found.");
      }
    } catch (e) {
      throw DefaultException(
          message: "An unknown error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Usermodel> signup(
      {required Usermodel user, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: password);

      if (credential.user == null) {
        throw DefaultException(message: "Failed to get UserCredential.");
      }

      final userdata = user.copyWith(uid: credential.user!.uid);
      await Apis.userDocumentRef(userdata.uid!).set(userdata.toJson());
      await SpData.setprafdata(SpData.userid, credential.user!.uid);
      return userdata;
    } catch (e) {
      throw DefaultException(
          message: "An unknown error occurred: ${e.toString()}");
    }
  }

  Future<void> relogin() async {
    final _usercontroller = Get.find<UserController>();
    final id = SpData.getprafdata(SpData.userid);

    if (id.isNotEmpty) {
      try {
        final data = await Apis.userDocumentRef(id).get();
        if (data.exists) {
          final userdata =
              Usermodel.fromJson(FirebaseResponseModel.fromResponse(data), id);
          _usercontroller.setUser(userdata);
          Get.offNamed(Routes.home);
        } else {
          print("User not found");
          Get.offNamed(Routes.Loginview);
        }
      } catch (e) {
        print("Relogin Error: ${e.toString()}");
        Get.offNamed(Routes.Loginview);
      }
    } else {
      Get.offNamed(Routes.Loginview);
    }
  }
}
