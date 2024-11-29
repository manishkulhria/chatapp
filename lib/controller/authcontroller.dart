import 'package:chat_app/model/authmodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var _user = Usermodel().obs;
  Usermodel get user => _user.value;

  // Method to set user data
  void setUser(Usermodel userdata) {
    _user.value = userdata;
  }

  //  loading
  var _loading = false.obs;
  bool get loading => _loading.value;

  //  set loading
  void setLoading(bool status) {
    _loading.value = status;
  }
}
