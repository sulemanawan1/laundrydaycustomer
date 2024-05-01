import 'package:flutter/material.dart';

class ColorManager {
  ColorManager._();

  static Color primaryColor = const Color.fromRGBO(0, 196, 141, 1);
  static Color primaryColorOpacity10 = const Color.fromRGBO(0, 196, 141, 0.1);
  static Color secondaryColor = const Color.fromARGB(255, 11, 114, 15);
  static Color blackColor = Colors.black;
  static Color redColor = Colors.redAccent;
  static Color blueColor = Colors.blue;
  static Color amber = Colors.amber;
  static Color purpleColor = const Color(0xFF60157d);
  static Color purpleColorOpacity10 = const Color(0xFF60157d).withOpacity(0.1);

  // static Color darkPurpleColor = const Color(0xFF563696);
  static Color greyColor = const Color(0xff828282);
  static Color lightGrey = const Color.fromRGBO(245, 242, 244, 1);
  static Color lightPurple = const Color(0xFFfdf5ff);
  static Color whiteColor = Colors.white;
  static Color mediumWhiteColor = const Color(0xfff9fafc);
  static Color backgroundColor = const Color.fromRGBO(241, 240, 245, 1);
  static Color tranparentColor = Colors.transparent;
  static Color blackOpacity45 = const Color.fromRGBO(0, 0, 0, 0.45);
}
