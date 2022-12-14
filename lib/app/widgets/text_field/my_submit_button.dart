import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          //color: context.theme.backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kRadius12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(
              text: text, //color: context.theme.cardColor
            ),
            const Icon(
              Icons.chevron_right, //color: context.theme.cardColor
            ),
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

        //color: context.theme.backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigText(
            text: text, //color: context.theme.cardColor
          ),
          Icon(
            Icons.chevron_right, color: Get.context?.theme.cardColor
          ),
        ],
      ),
    ),
  );
}
