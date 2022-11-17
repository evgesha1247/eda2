import 'package:flutter/material.dart';
import 'package:text/app/theme/theme_app.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final int maxLines;
  final Color? color;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final double decorationThickness;
  final FontWeight fontWeight;

  const BigText({
    Key? key,
    required this.text,
    this.color = const Color.fromARGB(255, 224, 224, 224),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    this.maxLines = 1,
    this.fontWeight = FontWeight.w500,
    this.decoration = TextDecoration.none,
    this.decorationThickness = 2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        decorationColor: color,
        decorationThickness: decorationThickness,
        decoration: decoration,
        fontSize: size == 0 ? ThemeAppSize.kFontSize22 : size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final double height;
  final int? maxLines;
  final Color? color;
  final TextOverflow overflow;
  const SmallText({
    Key? key,
    required this.text,
    this.color = const Color.fromARGB(255, 195, 195, 195),
    this.overflow = TextOverflow.ellipsis,
    this.height = 1.2,
    this.size = 0,
    this.maxLines = 2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size == 0 ? ThemeAppSize.kFontSize20 : size,
        color: color,
        height: height,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
