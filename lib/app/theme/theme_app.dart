
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String fontFamily = 'Mariupol';

const _textStyle = TextStyle(
  fontFamily: fontFamily,
  color: ThemeAppColor.kFrontColor,
  height: 1.2,
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);

const textTheme = TextTheme(
  bodyMedium: _textStyle,
);

class Themes {

  static final light = ThemeData.light().copyWith(
    // text
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    //main
    scaffoldBackgroundColor: ThemeAppColor.kBGColor,
    cardColor: ThemeAppColor.kFrontColor,
    primaryColor: ThemeAppColor.kAccent,
    // text
    hintColor: ThemeAppColor.kFrontColor,

  );

  static final dark = ThemeData.dark().copyWith(
    // text
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    //main
    scaffoldBackgroundColor: ThemeAppColor.kFrontColor,
    cardColor: const Color.fromARGB(255, 106, 76, 80),
    primaryColor: ThemeAppColor.kAccent,
    // text
    hintColor: ThemeAppColor.kTextDark,


  );
}

abstract class ThemeAppColor {
  static const Color kFrontColor = Color.fromARGB(255, 75, 53, 56);
  static const Color kBGColor = Color.fromARGB(255, 246, 206, 195);


  static const Color kAccent = Colors.pink;
  static const Color kAccentCard = Color.fromARGB(193, 130, 24, 59);

  static const Color kGreen = Color.fromRGBO(76, 175, 80, 1);
  static const Color kYellow = Color.fromARGB(255, 255, 207, 95);

  // text
  static const Color kTextDark = Color.fromARGB(255, 189, 159, 151);
  static const Color kTextLight = Color.fromARGB(255, 255, 207, 95);
}

abstract class ThemeAppSize {
  static double height = 780.0;
  static double width = 392.72;
  static double kScreensHeight = Get.context!.height;
  static double kScreensWidth = Get.context!.width;
  static double kMaxMinWidth = 320;

  // радиус
  static double kRadius12 = kScreensHeight / (height / 12);
  static double kRadius18 = kScreensHeight / (height / 18);
  // отступы
  static double kInterval5 = kScreensHeight / (height / 5);
  static double kInterval12 = kScreensHeight / (height / 12);
  static double kInterval24 = kScreensHeight / (height / 24);
  // fonts
  static double kFontSize16 = kScreensHeight / (height / 16);
  static double kFontSize18 = kScreensHeight / (height / 18);
  static double kFontSize20 = kScreensHeight / (height / 20);

  static double kHeight100 = kScreensHeight / (height / 100);
  static double kHeight75 = kScreensHeight / (height / 75);

  /// home page
  static double kHomePageView = kScreensHeight / (height / 190);
  static double kHomeListViewInfo = kScreensHeight / (height / 80);
  static double kHomePageViewOpen = kScreensHeight / (height / 150);

  /// ditalit page
  static double kDetaildHeaderImg = kScreensHeight / (height / 280);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);

// home menu
  static double kMenuHeaderSearch = kHeight75;
  static double kMenuHeaderFilter = kHeight75 - kInterval24;
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
