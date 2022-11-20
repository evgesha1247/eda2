import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemeAppColor {
  static const Color kWhite = Color.fromARGB(255, 221, 221, 227);
  static const Color kBlack = Color.fromARGB(255, 15, 15, 15);
  /// неплохое решение
  static const Color kFrontColor = Color(0xff553b3e); //0xff553b3e 0xff442c2e
  static const Color kBGColor = Color(0xffFedbd0);
  static const Color kAccent2 = Color.fromARGB(255, 113, 80, 84);
  static const Color grey = Color.fromARGB(255, 160, 113, 118);
  static const Color kAccent = Colors.pink;

}

abstract class ThemeAppSize {
  static double height = 780.0;
  static double width = 392.72;
  static double kScreensHeight = Get.context!.height;
  static double kScreensWidth = Get.context!.width;

// отступы
  static double kRadius12 = kScreensHeight / (height / 12);
  static double kRadius20 = kScreensHeight / (height / 20);
  static double kInterval5 = kScreensHeight / (height / 5);
  static double kInterval12 = kScreensHeight / (height / 12);
  static double kInterval24 = kScreensHeight / (height / 24);
// home screen
  // page view
  static double kPageView = kScreensHeight / (height / 275);
  static double kPageViewContainer = kScreensHeight / (height / 190);
  static double kPageViewTextContainer = kScreensHeight / (height / 165);
  // list view
  static double kListViewImgSize = kScreensHeight / (height / 150);
  static double kListViewTextContainer = kScreensHeight / (height / 120);
  // ditalit
  static double kDetaildImgContainer = kScreensHeight / (height / 350);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);
  // menu filter
  static double kMenuFilter = kScreensHeight / (height / 80);
  static double kMenuFilterItemWidth = kScreensWidth / (width / 4);
  static double kNebuFilterItemContaiter = (kScreensWidth / 4);



/// fonts
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
