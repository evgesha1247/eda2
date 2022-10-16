import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/theme/theme_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final widgetFactory = ScreensFactory();
    return SplashScreenView(
      navigateRoute: widgetFactory.makeGuiding(),
      duration: 3000,
      speed: 6000,
      imageSize: 500,
      imageSrc: ThemeAppImgURL.imgURLlogo,
      text: "loading...",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
      colors: const [
        ThemeAppColor.kFrontColor,
        ThemeAppColor.kWhite,
        ThemeAppColor.kWhite,
        ThemeAppColor.kFrontColor,
      ],
      backgroundColor: ThemeAppColor.kBGColor,
    );
  }
}
