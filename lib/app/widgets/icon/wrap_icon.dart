import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_app.dart';

class WrapperIcon extends StatelessWidget {
  final IconData icon;
  final Color? colorBorder;
  final Color? colorIcon;
  final Color? bg;
  const WrapperIcon({
    required this.icon,
    super.key,
    this.colorBorder = Colors.transparent,
    this.colorIcon,
    this.bg = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kInterval5 * 2),
          ),
          border: Border.all(color: colorBorder as Color, width: 1)),
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval5 * 1.5),
        child: Icon(icon, color: colorIcon ?? context.theme.hintColor),
      ),
    );
  }
}
