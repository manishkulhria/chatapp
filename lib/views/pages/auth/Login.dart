import 'package:chat_app/backend/repo/authhandler.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/resource/Validators/app_validators.dart';
import 'package:chat_app/resource/config/routes/app_route.dart';
import 'package:chat_app/views/components/Button/primarybtn.dart';
import 'package:chat_app/views/components/Textfield/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  Rx<bool> showpassword = false.obs;

  void _login() async {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await AuthDataHandler().login(
        email: _email.text,
        password: _password.text,
      );
      Get.toNamed(Routes.home);
    }
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appstyle.appcolors.Lightgrey,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(100),
                    // Center(
                    //     child: Image.asset(appstyle.appimg.Loginimg,
                    //         height: 200)),
                    Center(
                        child: Text("CHATAPP",
                            style: appstyle.textthme.fs20_semibold
                                .copyWith(color: appstyle.appcolors.grey))),
                    Gap(10),
                    Center(
                        child: Text("Login",
                            style: appstyle.textthme.fs16_semibold
                                .copyWith(color: appstyle.appcolors.grey))),
                    Gap(40),
                    Text("Email",
                        style: appstyle.textthme.fs16_semibold
                            .copyWith(color: appstyle.appcolors.darkgrey)),
                    Gap(5),
                    Textfieldwidget(
                        validator: EmailValidator(),
                        controller: _email,
                        hinttext: "Enter your email"),
                    Gap(20),
                    Text("Password",
                        style: appstyle.textthme.fs16_semibold
                            .copyWith(color: appstyle.appcolors.darkgrey)),
                    Gap(5),
                    Obx(
                      () => Textfieldwidget(
                          suffic: true,
                          suffixIcon: showpassword.value == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          obscureText: showpassword.value,
                          sufficontab: () {
                            showpassword.value = !showpassword.value;
                          },
                          validator: PasswordValidator(),
                          controller: _password,
                          hinttext: "Enter your password"),
                    ),
                    Gap(10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgot Password?",
                          style: appstyle.textthme.fs16_regular
                              .copyWith(color: appstyle.appcolors.primary)),
                    ),
                    Gap(40),
                    Row(children: [
                      Primarybtn(
                          isExpanded: true,
                          loading: loading,
                          name: "Login",
                          onPressed: _login),
                    ]),
                    Gap(10),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.Signup);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Don’t have an account? ",
                          style: appstyle.textthme.fs16_regular
                              .copyWith(color: appstyle.appcolors.grey),
                          children: [
                            TextSpan(
                                text: " Sign Up",
                                style: appstyle.textthme.fs16_regular.copyWith(
                                    color: appstyle.appcolors.primary))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
