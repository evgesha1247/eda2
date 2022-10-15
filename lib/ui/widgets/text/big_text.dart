import 'package:flutter/material.dart';
import 'package:text/ui/theme/theme_app.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final int maxLines;
  final Color? color;
  final TextOverflow overflow;
  const BigText({
    Key? key,
    required this.text,
    this.color = const Color.fromARGB(255, 224, 224, 224),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    this.maxLines = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size == 0 ? ThemeAppSize.kFontSize22 : size,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
