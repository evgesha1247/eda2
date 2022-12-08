import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/text/my_text.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ThemeAppSize.kInterval12,
      left: ThemeAppSize.kInterval12,
      right: ThemeAppSize.kInterval12,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ButtonIconBack(
                iconColor: context.theme.hintColor,
              ),
            ),
          ),
          BigText(
            text: 'Cart',
            color: context.theme.hintColor,
            size: ThemeAppSize.kFontSize22,
          ),
        ],
      ),
    );
  }
}
