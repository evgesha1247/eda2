import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';

import 'my_text.dart';

class ExpandableController extends GetxController {
  late String firstText;
  late String secondText;
  bool hiddeText = true;

  initText(String text) {
    double heightText = ThemeAppSize.kListViewInfo;
    if (text.length > heightText) {
      firstText = text.substring(0, heightText.toInt());
      secondText = text.substring(heightText.toInt() - 1, text.length);
    } else {
      firstText = text;
      secondText = '';
    }
  }

  tog() {
    hiddeText = !hiddeText;
    update();
  }
}

class ExpandableTextWidget extends StatelessWidget {
  const ExpandableTextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Get.put(ExpandableController()).initText(text);
    return GetBuilder<ExpandableController>(
      builder: (_) => _.secondText != ''
          ? SmallText(text: _.firstText, color: ThemeAppColor.kFrontColor)
          : SingleChildScrollView(
              child: Column(
                children: [
                  SmallText(
                    height: 1.6,
                    size: ThemeAppSize.kFontSize18,
                    text: _.hiddeText
                        ? ('${_.firstText}. . .')
                        : _.firstText + _.secondText,
                    color: ThemeAppColor.kFrontColor,
                    maxLines: 99,
                  ),
                  InkWell(
                    onTap: () => _.tog(),
                    child: Row(
                      children: [
                        BigText(
                          text: _.hiddeText ? 'show' : 'close',
                          color: ThemeAppColor.kFrontColor,
                          size: ThemeAppSize.kFontSize20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
