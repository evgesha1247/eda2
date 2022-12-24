import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/expandable_text.dart';
import '../../../widgets/text/my_text.dart';

class BodyDetailed extends StatelessWidget {
  const BodyDetailed({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: 'Introduce',
              color: context.theme.hintColor,
            ),
            SizedBox(
              height: context.height / 1.7,
              child: ExpandableTextWidget(
                text: description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
