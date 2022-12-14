// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
const String fontFamily = 'Mariupol';

const _textStyleLight = TextStyle(
  fontFamily: fontFamily,
  color: ThemeAppColor.kFrontColor,
  height: 1.2,
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);
const textThemeLight = TextTheme(
  bodyMedium: _textStyleLight,
);
const _textStyleDark = TextStyle(color: ThemeAppColor.kFrontColor);
const textThemeDark = TextTheme(
  bodyMedium: _textStyleDark,
);

class Themes {



  static final light = ThemeData.light().copyWith(
    // text
    textTheme: textThemeLight,
    primaryTextTheme: textThemeLight,
    //main
    scaffoldBackgroundColor: ThemeAppColor.kBGColor,
    cardColor: ThemeAppColor.kFrontColor,
    primaryColor: ThemeAppColor.kAccent,
    // text
    hintColor: ThemeAppColor.kFrontColor,
    // static
    accentColor: ThemeAppColor.kBGColor,
  );


  static final dark = ThemeData.dark().copyWith(
    // text
    textTheme: textThemeDark,
    primaryTextTheme: textThemeDark,
    //main
    scaffoldBackgroundColor: ThemeAppColor.kFrontColor,
    cardColor: const Color.fromARGB(255, 106, 76, 80),
    primaryColor: ThemeAppColor.kAccent,
    // text
    hintColor: const Color.fromARGB(255, 189, 159, 151),
    // static
    accentColor: ThemeAppColor.kBGColor,
  );
}

abstract class ThemeAppColor {
  static const Color kFrontColor = Color.fromARGB(255, 75, 53, 56);
  static const Color kBGColor = Color.fromARGB(255, 246, 206, 195);
  static const Color kAccent = Colors.pink;
  static const Color kAccent2 = Color.fromARGB(255, 72, 51, 54);
  static const Color grey = Color.fromARGB(255, 160, 113, 118);
  static const Color darkTextColor = Color.fromARGB(255, 0, 0, 0);
  static const Color lightTextColor = Color.fromARGB(255, 255, 255, 255);
}

abstract class ThemeAppSize {
  static double height = 780.0;
  static double width = 392.72;
  static double kScreensHeight = Get.context!.height;
  static double kScreensWidth = Get.context!.width;

  // радиус
  static double kRadius12 = kScreensHeight / (height / 12);
  static double kRadius18 = kScreensHeight / (height / 18);
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
  static double kHomePageView = kScreensHeight / (height / 220);
  static double kHomePageViewError = kScreensHeight / (height / 120);
  // list view
  static double kHomeListView = kScreensHeight / (height / 150);
  static double kHomeListViewInfo = kScreensHeight / (height / 120);

// ditalit page
  static double kDetaildHeaderImg = kScreensHeight / (height / 280);
  static double kDetaildHeaderImgToolbar = kScreensHeight / (height / 100);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);

// home menu
  static double kMenuHeaderSearch = kScreensHeight / (height / 75);
  static double kMenuHeaderFilter = kScreensHeight / (height / 75);
}

abstract class ThemeAppFun {
  static decoration({double radius = 0}) {
    return BorderRadius.all(
      Radius.circular(radius == 0 ? ThemeAppSize.kRadius18 : radius),
    );
  }

  static void printSnackBar(String message, {String title = 'Item count'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Get.context?.theme.primaryColor.withOpacity(0.7),
      colorText: Get.context?.theme.cardColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
  }
}
