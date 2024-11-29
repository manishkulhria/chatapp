import 'package:chat_app/backend/repo/authhandler.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/model/authmodel.dart';
import 'package:chat_app/resource/Validators/app_validators.dart';
import 'package:chat_app/resource/config/routes/app_route.dart';
import 'package:chat_app/views/components/Button/primarybtn.dart';
import 'package:chat_app/views/components/Textfield/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  void _signup() async {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await AuthDataHandler().signup(
          user: Usermodel(username: _name.text, email: _email.text),
          password: _password.text,
        );
        Get.toNamed(Routes.home);
      } catch (e) {
        print(e.toString());
        Get.snackbar(
          'Signup Error',
          'An unexpected error occurred.',
          backgroundColor: appstyle.appcolors.primary,
          colorText: appstyle.appcolors.whitecolor,
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
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
                      //     child: Image.asset(appstyle.appimg.signupimg,
                      //         height: 200)),
                      // Gap(10),
                      Center(
                          child: Text("Sign Up",
                              style: appstyle.textthme.fs16_semibold
                                  .copyWith(color: appstyle.appcolors.grey))),
                      Gap(20),
                      Text("Username",
                          style: appstyle.textthme.fs16_semibold
                              .copyWith(color: appstyle.appcolors.darkgrey)),
                      Gap(5),
                      Textfieldwidget(
                          validator: UserValidator(),
                          controller: _name,
                          hinttext: "Please Enter your name"),
                      Gap(20),
                      Text("Email",
                          style: appstyle.textthme.fs16_semibold
                              .copyWith(color: appstyle.appcolors.darkgrey)),
                      Gap(5),
                      Textfieldwidget(
                          validator: EmailValidator(),
                          controller: _email,
                          hinttext: "Enter your email"),
                      Gap(10),
                      Text("Password",
                          style: appstyle.textthme.fs16_semibold
                              .copyWith(color: appstyle.appcolors.darkgrey)),
                      Gap(5),
                      Textfieldwidget(
                          validator: PasswordValidator(),
                          controller: _password,
                          hinttext: "Enter your password"),
                      Gap(20),
                      Row(children: [
                        Primarybtn(
                            isExpanded: true,
                            loading: loading,
                            name: "Signup",
                            onPressed: _signup)
                      ]),
                      Gap(10),
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.Loginview);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: appstyle.textthme.fs16_regular
                                .copyWith(color: appstyle.appcolors.grey),
                            children: [
                              TextSpan(
                                  text: " Login",
                                  style: appstyle.textthme.fs16_regular
                                      .copyWith(
                                          color: appstyle.appcolors.primary))
                            ],
                          ),
                        ),
                      )),
                    ]),
              ),
            ),
          ),
        ));
  }
}
