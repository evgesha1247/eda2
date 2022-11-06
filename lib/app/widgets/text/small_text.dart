import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';

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
