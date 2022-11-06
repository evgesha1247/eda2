import 'package:flutter/material.dart';
import 'package:text/app/theme/theme_app.dart';

class MyIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final Color bgColor;
  const MyIcon({
    Key? key,
    required this.icon,
    this.size = 40,
    this.iconColor = const Color.fromARGB(255, 80, 35, 20),
    this.bgColor = const Color.fromARGB(255, 255, 237, 230),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2), color: bgColor),
      child: Icon(icon, color: iconColor, size: ThemeAppSize.kFontSize16),
    );
  }
}
