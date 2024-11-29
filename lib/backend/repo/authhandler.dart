import 'package:chat_app/backend/Exception/AppExceptions.dart';
import 'package:chat_app/backend/repo/Sharepref.dart';
import 'package:chat_app/backend/repo/auth_repositary.dart';
import 'package:chat_app/controller/authcontroller.dart';
import 'package:chat_app/model/authmodel.dart';
import 'package:chat_app/resource/config/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthDataHandler {
  final _repo = AuthRepositry();
  final UserController _userController = Get.find<UserController>();

  Future<void> signup(
      {required Usermodel user, required String password}) async {
    try {
      final usersnapshot = await _repo.signup(user: user, password: password);
      _userController.setUser(usersnapshot);
      await SpData.setprafdata(SpData.userid, usersnapshot.uid!);
      await setUserOnlineStatus(true);
      Get.toNamed(Routes.home);
    } on AppExceptions catch (e) {
      print("345345$e");
      throw e;
    } catch (e) {
      print(e.toString());
      throw DefaultException(
          message: 'An unknown error occurred. Please try again later.');
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final usersnapshot = await _repo.login(email: email, password: password);
      _userController.setUser(usersnapshot);
      await SpData.setprafdata(SpData.userid, usersnapshot.uid!);
      await setUserOnlineStatus(true);
      Get.toNamed(Routes.home);
    } on AppExceptions catch (e) {
      throw Get.snackbar("Error", e.toString());
    } catch (e) {
      print(e.toString());
      throw DefaultException(
          message: 'An unknown error occurred. Please try again later.');
    }
  }

  void logout() {
    SpData.removeprafdata(SpData.userid);
    FirebaseAuth.instance.signOut();
    _userController.setUser(Usermodel());
    setUserOnlineStatus(false);
    Get.toNamed(Routes.Loginview);
  }

  // --------------
  Future<void> setUserOnlineStatus(bool isOnline) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('User').doc(userId).set(
      {
        'online': isOnline,
        'lastSeen':
            isOnline ? null : Timestamp.now(), // Store last seen when offline
      },
      SetOptions(merge: true), // Merge to avoid overwriting other fields
    );
  }
}
