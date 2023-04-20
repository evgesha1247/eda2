import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../text/my_text.dart';

class ButtonIconBack extends StatelessWidget {
  final Color iconColor;
  final Color bg;
  const ButtonIconBack({
    super.key,
    this.iconColor = Colors.transparent,
    this.bg = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: WrapperIcon(
        bg: bg != Colors.transparent ? bg.withOpacity(0.7) : Colors.transparent,
        colorBorder:
            iconColor == Colors.transparent ? context.theme.cardColor : iconColor,
        icon: Icons.arrow_back_ios_new,
        colorIcon: iconColor == Colors.transparent ? context.theme.cardColor : iconColor,
      ),
    );
  }
}

class ButtonIconCart extends StatelessWidget {
  const ButtonIconCart({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Widget wrap(child) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor.withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kInterval5 * 2),
          ),
          border: Border.all(color: context.theme.hintColor),
        ),
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval5 * 1.5),
          child: child,
        ),
      );
    }

    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getCart),
      child: GetBuilder<CartController>(
        builder: (_) {
          return Stack(
            children: [
              wrap(
                Row(
                  children: [
                    Icon(
                      _.totalItems >= 1
                          ? Icons.shopping_bag_rounded
                          : Icons.shopping_bag_outlined,
                      color: context.theme.hintColor,
                    ),
                    SizedBox(
                      width: _.totalItems >= 1 ? ThemeAppSize.kInterval24 : 0,
                    )
                  ],
                ),
              ),
              if (_.totalItems >= 1)
                Positioned(
                  left: ThemeAppSize.kInterval24,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: SmallText(
                      text: '${_.totalItems}',
                      color: context.theme.hintColor,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
