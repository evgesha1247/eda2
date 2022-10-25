import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';
import '../text/big_text.dart';

myAuthButton(fun, String text) {
  return InkWell(
    onTap: fun,
    child: Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigText(text: text, color: ThemeAppColor.kBGColor),
          const Icon(Icons.chevron_right, color: ThemeAppColor.kBGColor),
        ],
      ),
    ),
  );
}
