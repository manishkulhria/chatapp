import 'package:chat_app/backend/repo/auth_repositary.dart';
import 'package:chat_app/views/components/Constants/Appcolor.dart';
import 'package:chat_app/views/components/Constants/img_icon.dart';
import 'package:chat_app/views/components/Constants/style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  splash() {
    Future.delayed(Duration(seconds: 8), () => AuthRepositry().relogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 216, 187),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: Image.asset(Appimages().splashimg, height: 300)),
          Gap(20),
          Text("CHAT APP ",
              style: Apptextstyle()
                  .fs24_semibold
                  .copyWith(color: AppColor().primary))
        ]));
  }
}
