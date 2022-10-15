import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemeAppColor {
  static const Color kWhite = Color.fromARGB(255, 221, 221, 227);
  static const Color kBlack = Color.fromARGB(255, 15, 15, 15);


  static const Color kAccent = Color.fromARGB(255, 255, 121, 101);
  static const Color kFrontColor = Color.fromARGB(255, 80, 35, 20);
  static const Color kBGColor = Color.fromARGB(255, 255, 237, 230);
  static const Color kAccent2 = Color.fromARGB(255, 100, 55, 50);


  // static const Color kAccent2 = Color.fromARGB(255, 47, 46, 64);
  // static const Color kFrontColor = Color.fromARGB(255, 42, 45, 61);
  // static const Color kBGColor = Color.fromARGB(255, 32, 35, 51);
  // static const Color kAccent = Color(0xffF7C701);
  /////////////////////////////////////////////////////

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
// iconSize
  static double kIcon16 = kScreensHeight / (height / 16);

// home screen
  // page view
  static double kPageView = kScreensHeight / (height / 270);
  static double kPageViewContainer = kScreensHeight / (height / 190);
  static double kPageViewTextContainer = kScreensHeight / (height / 140);
  // list view
  static double kListViewImgSize = kScreensWidth / (width / 120);
  static double kListViewTextContainer = kScreensWidth / (width / 100);
  // ditalit
  static double kDetaildImgContainer = kScreensHeight / (height / 350);
  static double kDetaildButtomContainer = kScreensHeight / (height / 120);
  // menu filter
  static double kMenuFilter = kScreensHeight / (height / 80);
  static double kMenuFilterItemWidth = kScreensWidth / (width / 4);
  static double kNebuFilterItemContaiter = kScreensWidth / 4;



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
}
abstract class ThemeAppImgURL {
  static const String imgURLPromo1 = 'assets/imgs/food6.jpg';
  static const String imgURLPromo2 = 'assets/imgs/food7.jpg';
  static const String imgURLPromo3 = 'assets/imgs/food8.jpeg';
  static const String imgURLPromo4 = 'assets/imgs/food9.jpg';
  static const String imgURL1 = 'assets/imgs/food1.png';
  static const String imgURL2 = 'assets/imgs/food2.png';
  static const String imgURL3 = 'assets/imgs/food3.png';
  static const String imgURL4 = 'assets/imgs/food4.png';
  static const String imgURL5 = 'assets/imgs/food5.png';
  static const String imgURLlogo = 'assets/imgs/logo.png';
}

abstract class ThemeAppIconURL {
  static const String iconUrlDessert = 'assets/icons/dessert.png';
  static const String iconUrlDrink = 'assets/icons/iconDrink.png';
  static const String iconUrlReset = 'assets/icons/reset.png';
  static const String iconUrlIceCream = 'assets/icons/ice-cream.png';
  static const String iconUrlMainCourse = 'assets/icons/main_course.png';


}
