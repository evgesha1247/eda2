import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final int maxLines;
  final TextOverflow overflow;
  final double decorationThickness;
  final FontWeight fontWeight;
  final bool rightToLeft;
  final Color color;

  const BigText({
    Key? key,
    required this.text,
    this.color = Colors.transparent,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    this.maxLines = 1,
    this.fontWeight = FontWeight.w500,
    this.decorationThickness = 2,
    this.rightToLeft = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Text(
      textDirection: rightToLeft ? TextDirection.rtl : TextDirection.ltr,
      text,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        decorationThickness: decorationThickness,
        fontSize: size == 0 ? ThemeAppSize.kFontSize22 : size,
        color: color == Colors.transparent ? context.theme.hintColor : color,
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
  final Color color;
  final TextOverflow overflow;
  const SmallText({
    Key? key,
    required this.text,
    this.color = Colors.transparent,
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
        color: color == Colors.transparent ? context.theme.hintColor : color,
        height: height,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
