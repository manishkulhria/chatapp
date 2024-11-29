
import 'package:chat_app/views/components/Constants/Appcolor.dart';
import 'package:chat_app/views/components/Constants/img_icon.dart';
import 'package:chat_app/views/components/Constants/style_sheet.dart';

class SingleTonClass {
  
  SingleTonClass._init();
  static SingleTonClass get instance => SingleTonClass._init();

  // ---------------- APP COLORS ------------------

  final _appcolors = AppColor();
  AppColor get appcolors => _appcolors;
  // ---------------- APP TEXT THEME ------------------

  final _texttheme = Apptextstyle();
  Apptextstyle get textthme => _texttheme;

  // ---------------- APP IMAGE ------------------

  final _Appimg = Appimages();
  Appimages get appimg => _Appimg;
  // ---------------- APP ICON ------------------

  final _Appicon = Appicon();
  Appicon get appicon => _Appicon;
}
