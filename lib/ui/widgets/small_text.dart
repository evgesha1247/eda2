import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  double size;
  double height;
  int maxLines;
  Color? color;
  TextOverflow overflow;
  SmallText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF6c625f),
    this.overflow = TextOverflow.ellipsis,
    this.height = 1.2,
    this.size = 14,
    this.maxLines = 2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        height: height,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
