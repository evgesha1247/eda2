import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../routes/main_routes.dart';
import '../text/my_text.dart';
import 'menu_icon.dart';

class CartIcon extends StatelessWidget {
  final Color iconColor;
  final Color borderColor;
  final bool statusBorder;
  final double size;

  const CartIcon({
    super.key,
    this.iconColor = ThemeAppColor.kFrontColor,
    this.borderColor = ThemeAppColor.kFrontColor,
    this.statusBorder = true,
    this.size = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<CartController>(
        builder: (_) {
          return GestureDetector(
            onTap: () => Get.toNamed(MainRoutes.getCart()),
            child: CustomButtonIcon(
              sizePading: size == 0 ? ThemeAppSize.kInterval5 : size,
              icon: Row(children: [
                Icon(
                  _.totalItems >= 1
                      ? Icons.shopping_bag_rounded
                      : Icons.shopping_bag_outlined,
                  color: iconColor,
                  size: ThemeAppSize.kFontSize20,
                ),
                _.totalItems >= 1
                    ? SmallText(
                        text: '${_.totalItems}',
                        color: iconColor,
                        size: ThemeAppSize.kFontSize18,
                      )
                    : const SizedBox.shrink(),
              ]),
              bg: ThemeAppColor.kBGColor,
              colorBorder: iconColor,
              statusBorder: statusBorder,
            ),
          );
        },
      ),
    );
  }
}
