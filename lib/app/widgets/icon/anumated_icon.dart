import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/pages/primary_pages/menu/model/filter_model.dart';
import 'package:text/app/widgets/icon/wrapper_icon.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../controllers/cart_controller.dart';
import '../../pages/primary_pages/favorite/controller/favorite_controller.dart';
import '../../pages/primary_pages/menu/controller/menu_controller.dart';

class CartAddIcon extends StatelessWidget {
  final ProductModel product;
  final Function? fun;
  const CartAddIcon({
    super.key,
    required this.product,
    this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return WrapperIcon(
      colorBorder: context.theme.accentColor,
      statusBorder: true,
      child: GetBuilder<CartController>(
        builder: (controller) {
          return _AnimatedIconWidget(
            currIndex: (controller.existInCart(product) ? 0 : 1).obs,
            fun: () => fun ?? controller.addOneInCart(product),
            widget1:
                const Icon(Icons.done, color: Color.fromRGBO(76, 175, 80, 1)),
            widget2: Icon(Icons.add, color: context.theme.accentColor),
          );
        },
      ),
    );
  }
}

class FavoritIcon extends StatelessWidget {
  final ProductModel product;
  final Function? fun;
  const FavoritIcon({
    super.key,
    required this.product,
    this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return WrapperIcon(
      colorBorder: context.theme.accentColor,
      statusBorder: true,
      child: GetBuilder<FavoriteController>(
        builder: (controller) {
          return _AnimatedIconWidget(
            currIndex: (controller.existInFavorites(product) ? 0 : 1).obs,
            fun: () => fun ?? controller.upDataFavoriteList(product),
            widget1: const Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            widget2: Icon(
              Icons.favorite_outline,
              color: context.theme.accentColor,
            ),
          );
        },
      ),
    );
  }
}

class ButtonTogList extends StatelessWidget {
  const ButtonTogList({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => controller.togStatusList(),
          child: Icon(
            controller.renderingMethod == RenderingMethod.grid
                ? Icons.grid_view
                : Icons.list,
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
    final bool laun = Get.locale != const Locale('en', 'US');
    return GestureDetector(
      onTap: () {
        Get.updateLocale(
          laun ? const Locale('en', 'US') : const Locale('ru', 'RU'),
        );
      },
      child: BigText(text: laun ? 'ru' : 'en'),
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
