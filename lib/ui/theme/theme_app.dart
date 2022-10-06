import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemeAppColor {
  static const Color kWhite = Color.fromARGB(255, 221, 221, 227);
  static const Color kBlack = Color.fromARGB(255, 15, 15, 15);

  static const Color kTextBlackColor = Colors.black54;
  static const Color kTextWhiteColor = Colors.white54;

  static const Color kAccent = Color.fromARGB(255, 255, 136, 118);
  static const Color kFrontColor = Color.fromARGB(255, 102, 61, 37);
  static const Color kBGColor = Color.fromARGB(255, 249, 218, 194);

  // static const Color kFrontColor = Color.fromARGB(255, 42, 45, 61);
  // static const Color kBGColor = Color.fromARGB(255, 32, 35, 51);
  // static const Color kAccent = Color(0xffF7C701);
  /////////////////////////////////////////////////////

}

abstract class ThemeAppSize {
  static double height = 780.0;
  static double kRadius = kScreensHeight / (height / 12);
  static double kInterval5 = kScreensHeight / (height / 5);
  static double kInterval12 = kScreensHeight / (height / 12);
  static double kInterval24 = kScreensHeight / (height / 24);

  static double kScreensHeight = Get.context!.height;
  static double kScreensWidth = Get.context!.width;

  static double kPageView = kScreensHeight / (height / 270);
  static double kPageViewContainer = kScreensHeight / (height / 190);
  static double kPageViewTextContainer = kScreensHeight / (height / 140);

  static double kFontSize14 = kScreensHeight / (height / 14);
  static double kFontSize16 = kScreensHeight / (height / 16);
  static double kFontSize18 = kScreensHeight / (height / 18);
  static double kFontSize20 = kScreensHeight / (height / 20);
  static double kFontSize22 = kScreensHeight / (height / 22);
  static double kFontSize25 = kScreensHeight / (height / 25);
}

abstract class ThemeAppFun {
  static decoration({double radius = 0}) {
    return BorderRadius.all(
      Radius.circular(radius == 0 ? ThemeAppSize.kRadius : radius),
    );
  }
}
