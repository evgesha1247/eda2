import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/app/theme/theme_app.dart';

import 'my_text.dart';

class ExpandableTextWidgetModel extends ChangeNotifier {
  late String firstText;
  late String secondText;
  bool hiddeText = true;
  initText(String text) {
    double heightText = ThemeAppSize.kListViewTextContainer;
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
    notifyListeners();
  }
}

class ExpandableTextWidget extends StatelessWidget {
  const ExpandableTextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpandableTextWidgetModel(),
      child: _TextWidget(text: text),
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ExpandableTextWidgetModel>();
    model.initText(text);
    return SingleChildScrollView(
      child: model.secondText == ''
          ? SmallText(text: model.firstText, color: ThemeAppColor.kFrontColor)
          : Column(
              children: [
                SmallText(
                  height: 1.6,
                  size: ThemeAppSize.kFontSize18,
                  text: model.hiddeText
                      ? ('${model.firstText}. . .')
                      : (model.firstText + model.secondText),
                  color: ThemeAppColor.kFrontColor,
                  maxLines: 99,
                ),
                InkWell(
                  onTap: () => model.tog(),
                  child: Row(
                    children: [
                      const SmallText(
                        text: 'show more',
                        color: ThemeAppColor.kFrontColor,
                      ),
                      Icon(
                        color: ThemeAppColor.kFrontColor,
                        model.hiddeText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
