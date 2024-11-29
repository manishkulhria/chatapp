import 'package:chat_app/controller/authcontroller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
   
  }
}
