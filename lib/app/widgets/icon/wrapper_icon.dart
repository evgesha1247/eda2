import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_app.dart';

class WrapperIcon extends StatelessWidget {
  final Widget child;
  final bool statusBorder;
  final Color colorBorder;
  const WrapperIcon({
    super.key,
    required this.child,
    required this.statusBorder,
    required this.colorBorder,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval5 * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kInterval5 * 2),
        ),
        border:
            statusBorder ? Border.all(color: colorBorder, width: 1.5) : null,
      ),
      child: child,
    );
  }
}
