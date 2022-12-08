import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';

import 'my_text.dart';

class ExpandableController extends GetxController {
  late String firstText;
  late String secondText;
  bool hiddeText = true;

  initText(String text) {
    double heightText = 100;
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
      builder: (_) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(
              height: 1.4,
              size: ThemeAppSize.kFontSize18,
              text: (_.firstText + (_.hiddeText ? _.secondText : '...')),
              //color: Get.theme.backgroundColor,
              maxLines: 99,
            ),
            InkWell(
              onTap: () => _.tog(),
              child: BigText(
                text: _.hiddeText ? 'show' : 'close',
                //color: Get.theme.backgroundColor,
                size: ThemeAppSize.kFontSize20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
