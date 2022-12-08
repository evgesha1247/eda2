import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeAppController extends GetxController {
  bool isLightTheme = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ThemeAppController() {
    getThemeStatus();
  }
  saveThemeStatus() async {
    (await _prefs).setBool('theme', isLightTheme);
  }

  getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    });
    isLightTheme = await isLight;
    Get.changeThemeMode(isLightTheme ? ThemeMode.light : ThemeMode.dark);
    update();
  }

  tooggTheme() {
    isLightTheme = !isLightTheme;
    Get.changeThemeMode(
      isLightTheme ? ThemeMode.light : ThemeMode.dark,
    );
    saveThemeStatus();
    update();
  }
}

class Themes {
  final String fontFamily = 'Mariupol';

  static final light = ThemeData.light().copyWith(
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
    //main
    scaffoldBackgroundColor: ThemeAppColor.kFrontColor,
    cardColor: Color.fromARGB(255, 106, 76, 80),
    primaryColor: ThemeAppColor.kAccent,
    // text
    hintColor: Color.fromARGB(255, 189, 159, 151),
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
  static double kHomePageView = kScreensHeight / (height / 220);
  static double kHomePageViewImg = kScreensHeight / (height / 160);
  // list view
  static double kHomeListViewImg = kScreensHeight / (height / 130);
  static double kHomeListViewInfo = kScreensHeight / (height / 110);

// ditalit page
  static double kDetaildHeaderImg = kScreensHeight / (height / 280);
  static double kDetaildHeaderImgToolbar = kScreensHeight / (height / 100);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);

// home menu
  static double kMenuHeaderSearch = kScreensHeight / (height / 75);
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
      backgroundColor: Get.context?.theme.primaryColor.withOpacity(0.7),
      colorText: Get.context?.theme.cardColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
  }
}
