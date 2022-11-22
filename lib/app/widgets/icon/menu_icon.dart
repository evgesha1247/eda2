import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';

class CustomButtonIcon extends StatelessWidget {
  final Widget icon;
  final Color colorBorder;
  final Color bg;
  final bool statusBorder;
  final double sizePading;
  final double radius;
  const CustomButtonIcon({
    required this.icon,
    super.key,
    this.colorBorder = ThemeAppColor.kBGColor,
    this.bg = Colors.transparent,
    this.statusBorder = false,
    this.sizePading = 0,
    this.radius = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.all(
          Radius.circular(
            radius == 0 ? ThemeAppSize.kRadius12 : sizePading,
          ),
        ),
        border:
            statusBorder ? Border.all(color: colorBorder, width: 0.8) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          sizePading == 0 ? ThemeAppSize.kInterval5 : sizePading,
        ),
        child: icon,
      ),
    );
  }
}
