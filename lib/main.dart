import 'package:chat_app/Classes/Singletonclass.dart';
import 'package:chat_app/backend/repo/Sharepref.dart';
import 'package:chat_app/controller/Bindings/app_binding.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/resource/config/routes/Apppageroute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

late SingleTonClass appstyle;

SpData pref = SpData.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await pref.sharedSet();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appstyle = SingleTonClass.instance;
    return GetMaterialApp(
        initialRoute: AppPages.intialroute,
        getPages: AppPages.routes,
        title: 'Flutter Demo',
        initialBinding: AppBindings());
  }
}
