import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../routes/main_routes.dart';
import '../text/my_text.dart';
import 'menu_icon.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.toNamed(MainRoutes.getCart()),
          child: CustomButtonIcon(
            sizePading: ThemeAppSize.kInterval12,
            icon: _.totalItems >= 1
                ? Row(children: [
                    const Icon(Icons.shopping_bag_rounded),
                    SmallText(
                        text: '${_.totalItems}',
                        color: ThemeAppColor.kFrontColor)
                  ])
                : const Icon(Icons.shopping_bag_outlined),
            bg: ThemeAppColor.kBGColor,
          ),
        );
      },
    );
  }
}
