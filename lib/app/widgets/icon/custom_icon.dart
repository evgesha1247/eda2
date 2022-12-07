import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../text/my_text.dart';

class CustomButtonIcon extends StatelessWidget {
  final Widget child;
  final bool statusBorder;
  final Color colorBorder;
  final Color bg;
  final double size;
  const CustomButtonIcon({
    required this.child,
    super.key,
    this.colorBorder = const Color.fromARGB(255, 75, 53, 56),
    this.bg = Colors.transparent,
    this.size = 0.0,
    this.statusBorder = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
        border:
            statusBorder ? Border.all(color: colorBorder, width: 0.8) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(size == 0 ? ThemeAppSize.kInterval12 : size),
        child: child,
      ),
    );
  }
}

class ButtonIconBack extends StatelessWidget {
  final Color iconColor;
  final Color bg;
  const ButtonIconBack({
    super.key,
    this.iconColor = const Color.fromARGB(255, 75, 53, 56),
    this.bg = const Color.fromARGB(255, 246, 206, 195),
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: CustomButtonIcon(
        bg: bg,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: iconColor,
          size: ThemeAppSize.kFontSize22,
        ),
      ),
    );
  }
}

class ButtonIconCart extends StatelessWidget {
  final Color iconColor;
  final Color borderColor;
  final bool statusBorder;
  const ButtonIconCart({
    super.key,
    this.iconColor = const Color.fromARGB(255, 246, 206, 195),
    this.borderColor = const Color.fromARGB(255, 246, 206, 195),
    this.statusBorder = true,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getCart()),
      child: GetBuilder<CartController>(
        builder: (_) {
          return Stack(
            children: [
              CustomButtonIcon(
                bg: Get.theme.cardColor,
                colorBorder: borderColor,
                statusBorder: statusBorder,
                child: Row(children: [
                  Icon(
                    _.totalItems >= 1
                        ? Icons.shopping_bag_rounded
                        : Icons.shopping_bag_outlined,
                    // Icons.local_mall_rounded
                    //Icons.local_mall_outlined,
                    color: iconColor,
                    size: ThemeAppSize.kFontSize22,
                  ),
                  SizedBox(
                    width: _.totalItems >= 1 ? ThemeAppSize.kInterval12 : 0,
                  )
                ]),
              ),
              Positioned(
                left: ThemeAppSize.kInterval24,
                top: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: SmallText(
                    text: _.totalItems >= 1 ? '${_.totalItems}' : '',
                    color: iconColor,
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
