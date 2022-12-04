import 'package:flutter/material.dart';
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
          child: const BigText(
            text: 'Favorites',
            color: ThemeAppColor.kBGColor,
          ),
        ),
        Icon(
          Icons.favorite_border_outlined,
          color: ThemeAppColor.kBGColor,
          size: ThemeAppSize.kFontSize22,
        )
      ],
    );
  }
}
