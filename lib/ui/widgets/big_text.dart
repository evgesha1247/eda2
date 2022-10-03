import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final String text;
  double size;
  int maxLines;
  Color? color;
  TextOverflow overflow;
  BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF4c423f),
    this.overflow = TextOverflow.ellipsis,
    this.size = 20,
    this.maxLines = 1,
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
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
