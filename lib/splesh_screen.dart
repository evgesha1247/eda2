import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:text/const/const_app_img.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/theme/theme_app.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final _widgetFactory = ScreensFactory();

    return SplashScreenView(
      navigateRoute: _widgetFactory.makeGuiding(),
      duration: 3000,
      speed: 6000,
      imageSize: 130,
      imageSrc: ConstAppImgURL.imgURL2,
      text: "loading...",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        ThemeAppColor.kFrontColor,
        ThemeAppColor.kBGColor,
        ThemeAppColor.kBGColor,
        ThemeAppColor.kFrontColor,
      ],
      backgroundColor: ThemeAppColor.kAccent,
    );
  }
}
