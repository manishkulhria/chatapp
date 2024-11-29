import 'package:chat_app/main.dart';
import 'package:chat_app/resource/Validators/app_validators.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfieldwidget extends StatelessWidget {
  String? hinttext;
  IconData? suffixIcon;
  Color? bgcolr;
  bool suffic;
  bool obscureText;
  AppValidator? validator;
  TextEditingController? controller;
  Function? sufficontab;
  Textfieldwidget({
    super.key,
    this.hinttext,
    this.suffixIcon,
    this.bgcolr,
    this.obscureText = false,
    this.validator,
    this.sufficontab,
    this.controller,
    this.suffic = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator:
            validator == null ? null : (value) => validator!.validator(value),
        // ---DECORATION--
        decoration: InputDecoration(
            fillColor: appstyle.appcolors.whitecolor,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: appstyle.appcolors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: appstyle.appcolors.transparent)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: appstyle.appcolors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: appstyle.appcolors.red)),
            suffixStyle: appstyle.textthme.fs12_semibold
                .copyWith(color: appstyle.appcolors.blackcolor),
            // -------SUFFIC ICON BUTTON---
            suffixIcon: GestureDetector(
                onTap: () {
                  sufficontab != null ? sufficontab!() : null;
                },
                child: Icon(suffixIcon, color: appstyle.appcolors.blackcolor)),
            // -------TEXT---

            hintText: hinttext,
            hintStyle: appstyle.textthme.fs12_normal
                .copyWith(color: appstyle.appcolors.grey)));
  }
}
