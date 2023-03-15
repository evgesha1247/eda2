import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../../theme/theme_controller.dart';
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
    return GetBuilder<ThemeAppController>(
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: WrapperIcon(
            bg: bg,
            colorBorder: iconColor == Colors.transparent
                ? context.theme.textTheme.bodyMedium?.color
                : iconColor,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: iconColor == Colors.transparent
                  ? context.theme.textTheme.bodyMedium?.color
                  : iconColor,
            ),
          ),
        );
      },
    );
  }
}

class ButtonIconCart extends StatelessWidget {
  final Color iconColor;
  final Color bg;
  const ButtonIconCart({
    super.key,
    this.iconColor = Colors.transparent,
    this.bg = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getCart),
      child: GetBuilder<CartController>(
        builder: (_) {
          return Stack(
            children: [
              WrapperIcon(
                bg: bg,
                colorBorder: iconColor == Colors.transparent
                    ? context.theme.hintColor
                    : iconColor,

                child: Row(children: [
                  Icon(
                    _.totalItems >= 1
                        ? Icons.shopping_bag_rounded
                        : Icons.shopping_bag_outlined,
                    color: iconColor == Colors.transparent
                        ? context.theme.hintColor
                        : iconColor,
                  ),
                  SizedBox(
                    width: _.totalItems >= 1 ? ThemeAppSize.kInterval24 : 0,
                  )
                ]),
              ),
              _.totalItems >= 1
                  ? Positioned(
                      left: ThemeAppSize.kInterval24,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: SmallText(
                          text: '${_.totalItems}',
                          color: iconColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
