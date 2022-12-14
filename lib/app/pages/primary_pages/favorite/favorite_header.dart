// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class FavoritHeader extends StatelessWidget {
  const FavoritHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: BigText(
            text: 'Favorites',
            color: context.theme.accentColor,
          ),
        ),
        Icon(
          Icons.favorite_border_outlined,
          color: context.theme.accentColor,
          size: ThemeAppSize.kFontSize22,
        )
      ],
    );
  }
}
