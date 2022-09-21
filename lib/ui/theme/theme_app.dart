import 'package:flutter/material.dart';

abstract class ThemeApp {
  static const Color kFrontColor = Color.fromARGB(255, 42, 45, 61);
  //Color.fromARGB(255, 46, 43, 64);
  static const Color kBGColor = Color.fromARGB(255, 32, 35, 51);
  static const Color kAccent = Color(0xffF7C701);
  static const Color kWhite = Color(0xffeaeaea);

  static const kRadius = 12.0;
  static const kInterval = 12.0;
  static const kHeight = 33.0;

  static decoration({Color colors = kFrontColor}) {
    return BoxDecoration(
      color: colors,
      borderRadius: const BorderRadius.all(
        Radius.circular(ThemeApp.kRadius),
      ),
    );
  }

  static style({
    double size = 16,
    FontWeight fW = FontWeight.normal,
    Color colors = kWhite,
  }) {
    return TextStyle(
      color: colors,
      fontSize: size,
      fontWeight: fW,
      letterSpacing: 1.5,
      wordSpacing: 3.5,
    );
  }
}
