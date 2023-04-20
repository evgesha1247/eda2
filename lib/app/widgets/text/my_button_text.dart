import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_app.dart';
import 'my_text.dart';

class MyButtonString extends StatelessWidget {
  const MyButtonString({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval12,
        vertical: ThemeAppSize.kInterval5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.primaryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius12 / 2),
        ),
      ),
      child: Center(
        child: BigText(
          text: text,
          color: context.theme.primaryColor,
        ),
      ),
    );
  }
}
