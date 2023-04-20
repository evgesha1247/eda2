import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';

class WrapperIcon extends StatelessWidget {
  final Widget child;
  final Color? colorBorder;
  final Color? bg;
  const WrapperIcon({
    required this.child,
    super.key,
    this.colorBorder = Colors.transparent,
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
        child: child,
      ),
    );
  }
}
