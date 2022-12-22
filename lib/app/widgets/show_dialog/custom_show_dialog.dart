import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_app.dart';

Future customShowDialog({
  required Widget widget,
  double? radius,

}) async {
  return showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius ?? ThemeAppSize.kRadius12),
        )

        ),
        child: widget,
      );
    },
  );
}
