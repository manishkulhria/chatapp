import 'package:chat_app/resource/config/routes/app_route.dart';
import 'package:chat_app/views/pages/auth/Login.dart';
import 'package:chat_app/views/pages/auth/Signup.dart';
import 'package:chat_app/views/pages/auth/home/Homepage.dart';
import 'package:chat_app/views/pages/splash/splashview.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static const intialroute = Routes.splashscreen;
  static final routes = [
    GetPage(name: Routes.splashscreen, page: () => splash_screen()),
    GetPage(name: Routes.Loginview, page: () => Loginview()),
    GetPage(name: Routes.Signup, page: () => SignupView()),
    GetPage(name: Routes.home, page: () => Homepage()),
  ];
}
