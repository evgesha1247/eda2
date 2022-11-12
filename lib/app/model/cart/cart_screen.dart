import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';

import '../../data/object/dish_object.dart';
import 'cart_model.dart';

class CartScreen extends StatelessWidget {

  final controller = Get.find<CartModel>();
  CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _CartButtonBack(),
                  ),
                  BigText(
                    text: 'Cart',
                    color: ThemeAppColor.kFrontColor,
                  )
                ],
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              Expanded(
                child: GetBuilder<CartModel>(
                  builder: (c) {
                    return ListView.builder(
                      itemCount: c.cart.length,
                      itemBuilder: (context, index) {
                        return _cartRows(
                          model: controller,
              product: controller.cart.keys.toList()[index],
              index: index,
                          count: controller.cart.values.toList()[index],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              _BottnCart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartRows({
    required CartModel model,
    required Dish product,
    required int index,
    required int count,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: ThemeAppSize.kInterval12),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              spacing: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: ThemeAppColor.kFrontColor,
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              onPressed: (BuildContext context) {
                //  controller.delete(dishkey);
              },
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: ThemeAppFun.decoration(),
            color: ThemeAppColor.kFrontColor,
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Image(
                image: AssetImage(product.imgUrl),
                height: 100,
              ),
              _CartContent(
                model: controller,
                product: controller.cart.keys.toList()[index],
                index: index,
                count: controller.cart.values.toList()[index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  final CartModel model;
  final Dish product;
  final int index;
  final int count;
  const _CartContent({
    required this.model,
    required this.product,
    required this.index,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: product.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SmallText(text: 'price '),
                    SmallText(text: product.price.toString()),
                  ],
                ),
                SmallText(text: 'ₓ${count}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottnCart extends StatelessWidget {
  final controller = Get.find<CartModel>();
  _BottnCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
        borderRadius: ThemeAppFun.decoration(),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: ThemeAppSize.kInterval12,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SmallText(text: 'sub-total'),
              // GetBuilder<CartModel>(
              //   builder: (c) => SmallText(
              //     text: c.total.toStringAsFixed(2),
              //   ),
              // ),
            ],
          ),
          GetBuilder<CartModel>(
            builder: (c) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // controller.total > 3000
                //     ? const SmallText(text: 'save -15%')
                //     : controller.total > 1000
                //         ? const SmallText(text: 'delivery')
                //         : const SmallText(text: 'delivery'),
                // SmallText(text: c.promotions().toStringAsFixed(2))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
            child: const Divider(
              color: ThemeAppColor.kWhite,
              thickness: .3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: 'all total',
                size: ThemeAppSize.kFontSize25,
                color: ThemeAppColor.kBGColor,
              ),
              // GetBuilder<CartModel>(
              //   builder: (c) => BigText(
              //     text: (c.total + c.promotions()).toString(),
              //     size: ThemeAppSize.kFontSize25,
              //     color: ThemeAppColor.kBGColor,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: ThemeAppSize.kInterval12),
          GestureDetector(
            onTap: () {
              //   cart.clear();
              Get.snackbar(
                '',
                '',
                overlayBlur: 4,
                margin: EdgeInsets.all(ThemeAppSize.kInterval12),
                duration: const Duration(milliseconds: 1200),
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: ThemeAppColor.kFrontColor.withOpacity(0.3),
                icon: const Icon(Icons.check, color: Colors.green),
                titleText: const Text('Thanks for your order'),
                messageText: const SmallText(
                  text: 'positions in processing',
                  color: ThemeAppColor.kFrontColor,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeAppColor.kBGColor,
                borderRadius: ThemeAppFun.decoration(),
              ),
              child: const Center(
                child: BigText(
                  text: 'add to cart',
                  color: ThemeAppColor.kFrontColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartButtonBack extends StatelessWidget {
  const _CartButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(),
          color: ThemeAppColor.kFrontColor,
        ),
        padding: EdgeInsets.only(
          top: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval12,
          left: ThemeAppSize.kInterval12 + 10,
          right: ThemeAppSize.kInterval12,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeAppColor.kBGColor,
        ),
      ),
    );
  }
}
