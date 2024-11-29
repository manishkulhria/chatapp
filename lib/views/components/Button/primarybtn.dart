import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Primarybtn extends StatelessWidget {
  String name;
  bool isExpanded;
  Function onPressed;
  int? height;
  final bool loading;
  Color? backgroundColor, foregroundColor, borderclr;
  Primarybtn(
      {super.key,
      required this.name,
      this.isExpanded = false,
      required this.onPressed,
      this.backgroundColor,
      this.borderclr,
      this.loading = false,
      this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    final btn = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: appstyle.appcolors.transparent),
            backgroundColor: backgroundColor ?? appstyle.appcolors.primary,
            foregroundColor: foregroundColor ?? appstyle.appcolors.transparent),
        onPressed: () {
          onPressed();
        },
        child: loading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                    color: appstyle.appcolors.whitecolor))
            : Text(name,
                style: appstyle.textthme.fs20_semibold.copyWith(
                    color: foregroundColor == null
                        ? appstyle.appcolors.whitecolor
                        : foregroundColor)));
    return isExpanded ? Expanded(child: btn) : btn;
  }
}
