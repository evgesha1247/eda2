import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../../theme/theme_controller.dart';
import '../text/my_text.dart';

class WrapperIcon extends StatelessWidget {
  final Widget child;
  final bool statusBorder;
  final Color? colorBorder;
  final Color? bg;
  final double size;
  const WrapperIcon({
    required this.child,
    super.key,
    this.statusBorder = false,
    this.colorBorder = Colors.transparent,
    this.bg = Colors.transparent,
    this.size = 0.0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kInterval5 * 2),
        ),
        border: statusBorder
            ? Border.all(color: colorBorder as Color, width: 1.1)
            : null,
      ),
      child: Padding(
        padding:
            EdgeInsets.all(size == 0 ? ThemeAppSize.kInterval5 * 1.5 : size),
        child: child,
      ),
    );
  }
}

class ButtonIconBack extends StatelessWidget {
  final Color iconColor;
  final Color bg;
  final bool statusBorder;
  const ButtonIconBack({
    super.key,
    this.iconColor = Colors.transparent,
    this.bg = Colors.transparent,
      this.statusBorder = true
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeAppController>(
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: WrapperIcon(
            bg: bg,
            statusBorder: statusBorder,
            colorBorder: iconColor == Colors.transparent
                ? context.theme.textTheme.bodyMedium?.color
                : iconColor,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: iconColor == Colors.transparent
                  ? context.theme.textTheme.bodyMedium?.color
                  : iconColor,
              size: ThemeAppSize.kFontSize20,
            ),
          ),
        );
      },
    );
  }
}

class ButtonIconCart extends StatelessWidget {
  final Color iconColor;
  final bool statusBorder;
  final Color bg;
  const ButtonIconCart({
    super.key,
    this.iconColor = Colors.transparent,
    this.statusBorder = true,
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
                statusBorder: statusBorder,
                child: Row(children: [
                  Icon(
                    _.totalItems >= 1
                        ? Icons.shopping_bag_rounded
                        : Icons.shopping_bag_outlined,
                    color: iconColor == Colors.transparent
                        ? context.theme.hintColor
                        : iconColor,
                    size: ThemeAppSize.kFontSize20,
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
