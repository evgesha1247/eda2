import 'package:flutter/material.dart';
import 'package:text/ui/theme/theme_app.dart';

class MyIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final Color bgColor;
  const MyIcon({
    Key? key,
    required this.icon,
    this.size = 40,
    this.iconColor = const Color.fromARGB(255, 102, 61, 37),
    this.bgColor = const Color.fromARGB(255, 249, 218, 194),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: bgColor,
          border: Border.all(color: iconColor, width: 0.3)


      ),
      child: Icon(
        icon,
        color: iconColor,
        size: ThemeAppSize.kIcon16,
      ),
    );
  }
}
