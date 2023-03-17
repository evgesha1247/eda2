// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/pages/primary_pages/menu/model/filter_model.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../controllers/cart_controller.dart';
import '../../pages/primary_pages/profile/favorite/controller/favorite_controller.dart';
import '../../pages/primary_pages/menu/controller/menu_controller.dart';
import '../../theme/theme_app.dart';

class CartAddIcon extends StatelessWidget {
  final ProductModel product;
  final Color bg;
  final Color iconColor;
  const CartAddIcon({
    super.key,
    required this.product,
    this.bg = Colors.transparent,
    this.iconColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return _AnimatedIconWidget(
          currIndex: (controller.existInCart(product) ? 0 : 1).obs,
          fun: () => controller.addOneInCart(product),
          widget1: WrapperIcon(
            colorBorder: Colors.green[300],
            bg: bg != Colors.transparent
                ? bg.withOpacity(0.7)
                : Colors.transparent,
            child: const Icon(
              Icons.done,
              color: ThemeAppColor.kGreen,
            ),
          ),
          widget2: WrapperIcon(
            colorBorder: context.theme.accentColor,
            bg: bg != Colors.transparent
                ? bg.withOpacity(0.5)
                : Colors.transparent,
            child: Icon(
              Icons.add,
              color: iconColor == Colors.transparent
                  ? context.theme.accentColor
                  : iconColor,
            ),
          ),
        );
      },
    );
  }
}

class FavoritIcon extends StatelessWidget {
  final ProductModel product;
  final Color bg;
  final Color iconColor;
  const FavoritIcon({
    super.key,
    required this.product,
    this.bg = Colors.transparent,
    this.iconColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (controller) {
        return _AnimatedIconWidget(
          currIndex: (controller.existInFavorites(product) ? 0 : 1).obs,
          fun: () => controller.upDataFavoriteList(product),
          widget1: WrapperIcon(
            colorBorder: Colors.pink[300],
            bg: bg != Colors.transparent
                ? bg.withOpacity(0.7)
                : Colors.transparent,
            child: const Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          ),
          widget2: WrapperIcon(
            colorBorder: context.theme.accentColor,
            bg: bg != Colors.transparent
                ? bg.withOpacity(0.5)
                : Colors.transparent,
            child: Icon(
              Icons.favorite_outline,
              color: iconColor == Colors.transparent
                  ? context.theme.accentColor
                  : iconColor,
            ),
          ),
        );
      },
    );
  }
}

class ButtonTogList extends StatelessWidget {
  const ButtonTogList({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
      builder: (controller) {
        return _AnimatedIconWidget(
          currIndex:
              (controller.renderingMethod == RenderingMethod.grid ? 0 : 1).obs,
          fun: () => controller.togStatusList(),
          widget1: Icon(Icons.grid_view, color: context.theme.hintColor),
          widget2: Icon(
            Icons.list,
            color: context.theme.hintColor,
          ),
        );
      },
    );
  }
}

class ToggLanguage extends StatelessWidget {
  const ToggLanguage({super.key});
  @override
  Widget build(BuildContext context) {
    return _AnimatedIconWidget(
      currIndex: (Get.locale != const Locale('en', 'US') ? 0 : 1).obs,
      fun: () {
        Get.updateLocale(Get.locale != const Locale('en', 'US')
            ? const Locale('en', 'US')
            : const Locale('ru', 'RU'));
      },
      widget1: BigText(text: 'ru', color: context.theme.hintColor),
      widget2: BigText(text: 'en', color: context.theme.hintColor),
    );
  }
}

class _AnimatedIconWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final Function? fun;
  final RxInt currIndex;
  const _AnimatedIconWidget({
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
