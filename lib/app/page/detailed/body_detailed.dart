import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/expandable_text.dart';
import '../../widgets/text/my_text.dart';

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
            const BigText(
              text: 'Introduce',
              color: ThemeAppColor.kFrontColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.7,
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