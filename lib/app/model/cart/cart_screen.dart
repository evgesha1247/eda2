import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';

import '../../data/object/cart_object.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
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
                child: ListView.builder(
                  itemCount: cart.cartItem.length,
                  itemBuilder: (context, index) {
                    return _cartRows(index: index, cartModel: cart);
                  },
                ),
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              const _BottnCart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartRows({required cartModel, required int index}) {
    final img = cartModel.cartItem.values.elementAt(index).imgUrl;
    final dishkey = cartModel.cartItem.entries.toList()[index].key;
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
                cartModel.delete(dishkey);
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
                image: AssetImage(img),
                height: 100,
              ),
              _CartContent(index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final cartItems = cart.cartItem.values.elementAt(index);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: cartItems.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SmallText(text: 'price '),
                    SmallText(text: cartItems.price.toString()),
                  ],
                ),
                SmallText(text: 'ₓ${cartItems.number}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottnCart extends StatelessWidget {
  const _BottnCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final promotions = cart.promotions();
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
              SmallText(text: cart.total.toStringAsFixed(2)),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            cart.total > 3000
                ? const SmallText(text: 'save -15%')
                : cart.total > 1000
                    ? const SmallText(text: 'delivery')
                    : const SmallText(text: 'delivery'),
            SmallText(text: promotions.toStringAsFixed(2))
          ]),
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
              BigText(
                text: (cart.total + promotions).toString(),
                size: ThemeAppSize.kFontSize25,
                color: ThemeAppColor.kBGColor,
              ),
            ],
          ),
          SizedBox(height: ThemeAppSize.kInterval12),
          GestureDetector(
            onTap: () {
              cart.clear();
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
    final model = context.read<CartModel>();
    return GestureDetector(
      onTap: () => model.showMenu(context),
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
