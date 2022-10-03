import 'package:flutter/material.dart';

abstract class ThemeApp {
  static const Color kWhite = Color.fromARGB(255, 221, 221, 227);
  static const Color kBlack = Color.fromARGB(255, 15, 15, 15);
  static const Color kAccent2 = Color.fromARGB(255, 53, 56, 74);
  static const Color kAccent = Color.fromARGB(255, 168, 50, 82);
  static const Color kFrontColor = Color.fromARGB(255, 252, 233, 218);
  static const Color kBGColor = Color.fromARGB(255, 233, 182, 142);
  // static const Color kFrontColor = Color.fromARGB(255, 42, 45, 61);
  // static const Color kBGColor = Color.fromARGB(255, 32, 35, 51);
  // static const Color kAccent = Color(0xffF7C701);
  /////////////////////////////////////////////////////
  static const Color kMainColor = Color(0xFF89dad0);
  static const Color kMainBlacColor = Color(0xFF332d2d);
  static const Color kIconColor1 = Color(0xFFffd28d);
  static const Color kIconColor2 = Color(0xFFfcab88);
  static const Color kTitleColor = Color(0xFF4c423f);
  static const Color kTextColor = Colors.black54;

  static const kRadius = 12.0;
  static const kInterval = 12.0;
  static const kHeight = 33.0;

  static decoration({double radius = ThemeApp.kRadius}) {
    return BorderRadius.all(
      Radius.circular(radius),
    );
  }
}
