import 'package:flutter/cupertino.dart';
import 'package:text/ui/theme/theme_app.dart';

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
        fontSize: size == 0 ? ThemeAppSize.kFontSize20 : size,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
