import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../theme/theme_app.dart';
import 'custom_icon.dart';

class AnimatedIconWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final Function? fun;
  final RxInt currIndex;
  const AnimatedIconWidget({
    super.key,
    this.widget1 = const Icon(Icons.favorite),
    this.widget2 = const Icon(Icons.favorite_outline),
    this.fun,
    required this.currIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fun != null ? fun!() : null,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          transitionBuilder: (child, anim) => ScaleTransition(
                scale: child.key == const ValueKey('1')
                    ? Tween<double>(begin: 1, end: 1).animate(anim)
                    : Tween<double>(begin: 1, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
          child: currIndex.value == 0
              ? SizedBox(key: const ValueKey('1'), child: widget1)
            : SizedBox(key: const ValueKey('2'), child: widget2),
      ),
    );
  }
}

class CartAddIcon extends StatelessWidget {
  final ProductModel product;
  final bool statusBorder;
  final Color bg;
  const CartAddIcon({
    super.key,
    required this.product,
    this.statusBorder = false,
    this.bg = ThemeAppColor.kFrontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.existInCart(product) ? 0 : 1).obs,
          fun: () => controller.addOneInCart(product),
          widget1: CustomButtonIcon(
            colorBorder: Colors.green,
            bg: bg,
            size: ThemeAppSize.kInterval5,
            statusBorder: statusBorder,
            child: const Icon(Icons.done, color: Colors.green),
          ),
          widget2: CustomButtonIcon(
            size: ThemeAppSize.kInterval5,
            bg: bg,
            child: const Icon(Icons.add, color: ThemeAppColor.kBGColor),
          ),
        );
      },
    );
  }
}

class FavoritIcon extends StatelessWidget {
  final ProductModel product;
  final bool statusBorder;
  final Color bg;
  const FavoritIcon({
    super.key,
    required this.product,
    this.statusBorder = false,
    this.bg = ThemeAppColor.kFrontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.existInFavorites(product) ? 0 : 1).obs,
          fun: () => controller.upDataFavoriteList(product),
          widget1: CustomButtonIcon(
            bg: bg,
            colorBorder: ThemeAppColor.kAccent,
            size: ThemeAppSize.kInterval5,
            statusBorder: statusBorder,
            child: const Icon(Icons.favorite, color: ThemeAppColor.kAccent),
          ),
          widget2: CustomButtonIcon(
            bg: bg,
            size: ThemeAppSize.kInterval5,
            child: const Icon(
              Icons.favorite_outline,
              color: ThemeAppColor.kBGColor,
            ),
          ),
        );
      },
    );
  }
}
