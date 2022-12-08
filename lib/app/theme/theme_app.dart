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
    print(isLightTheme);
    update();
  }


}

class ThemeApp {
  static const String fontFamily = 'Mariupol';

  static final ThemeData myLightTheme = ThemeData.light().copyWith(


  );


  static final ThemeData myDarkThemes = ThemeData.dark().copyWith(

  );


  //  scaffoldBackgroundColor: const Color.fromARGB(255, 246, 206, 195),
  //   backgroundColor: const Color.fromARGB(255, 246, 206, 195), // kFrontColor
  //   primaryColor: Colors.pink, // kAccent
  //   cardColor: const Color.fromARGB(255, 75, 53, 56), // db
  //   hintColor: const Color.fromARGB(255, 160, 113, 118), //grey
  //   focusColor: const Color.fromARGB(255, 72, 51, 54), // kAccent2

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
      backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
      colorText: Get.theme.cardColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
  }

}
