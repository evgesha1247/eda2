import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';
import '../text/my_text.dart';

class MySubmitButton extends StatelessWidget {
  const MySubmitButton({super.key, required this.text, required this.fun});
  final String text;
  final Function() fun;
  @override
  Widget build(BuildContext context) {
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
}

mySubmitButton(fun, String text) {
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
