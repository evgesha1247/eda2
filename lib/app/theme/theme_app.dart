import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemeAppColor {

  /// неплохое решение
  // static const Color kFrontColor = Color(0xff553b3e);
  // static const Color kBGColor = Color(0xffFedbd0);
  // static const Color kAccent2 = Color.fromARGB(255, 113, 80, 84);
  // static const Color grey = Color.fromARGB(255, 160, 113, 118);
  // static const Color kAccent = Colors.pink;
  static const Color kFrontColor = Color.fromARGB(255, 75, 53, 56);
  static const Color kBGColor = Color.fromARGB(255, 246, 206, 195);
  static const Color kAccent2 = Color.fromARGB(255, 72, 51, 54);
  static const Color grey = Color.fromARGB(255, 160, 113, 118);
  static const Color kAccent = Colors.pink;

}

abstract class ThemeAppSize {
  static double height = 780.0;
  static double width = 392.72;
  static double kScreensHeight = Get.context!.height;
  static double kScreensWidth = Get.context!.width;

  // радиус
  static double kRadius12 = kScreensHeight / (height / 12);
  static double kRadius20 = kScreensHeight / (height / 20);
  // отступы
  static double kInterval5 = kScreensHeight / (height / 5);
  static double kInterval12 = kScreensHeight / (height / 12);
  static double kInterval24 = kScreensHeight / (height / 24);
  // fonts
  static double kFontSize18 = kScreensHeight / (height / 18);
  static double kFontSize20 = kScreensHeight / (height / 20);
  static double kFontSize22 = kScreensHeight / (height / 22);

// home page
  // page view
  static double kHomePageView = kScreensHeight / (height / 230);
  static double kHomePageViewImg = kScreensHeight / (height / 170);
  static double kHomePageViewInfo = kScreensHeight / (height / 120);
  // list view
  static double kHomeListViewImg = kScreensHeight / (height / 130);
  static double kHomeListViewInfo = kScreensHeight / (height / 110);

// ditalit page
  static double kDetaildHeaderImg = kScreensHeight / (height / 280);
  static double kDetaildHeaderImgToolbar = kScreensHeight / (height / 100);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);

// home menu
  static double kMenuHeaderSearch = kScreensHeight / (height / 70);


}

abstract class ThemeAppFun {
  static decoration({double radius = 0}) {
    return BorderRadius.all(
      Radius.circular(radius == 0 ? ThemeAppSize.kRadius20 : radius),
    );
  }
  static void printSnackBar(String message) {
    Get.snackbar(
      'Item count',
      message,
      backgroundColor: ThemeAppColor.kAccent.withOpacity(0.7),
      colorText: ThemeAppColor.kBGColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
  }

}
