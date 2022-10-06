import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:text/object/cart_object.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/big_text.dart';

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
                    return _CartRows(index: index);
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
}

class _CartRows extends StatelessWidget {
  const _CartRows({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final cartModel = context.watch<CartModel>();
    final dishkey = cartModel.cartItem.entries.toList()[index].key;
    return Padding(
      padding: EdgeInsets.only(bottom: ThemeAppSize.kInterval12),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
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
              _CartImg(index: index),
              _CartContent(index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartImg extends StatelessWidget {
  const _CartImg({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final img = cart.cartItem.values.elementAt(index).imgUrl;
    return Expanded(
      flex: 1,
      child: Image(
        image: AssetImage(img),
        height: 100,
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
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: cartItems.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: cartItems.price.toString()),
                BigText(text: 'ₓ${cartItems.number}'),
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
              const BigText(text: 'sub-total'),
              BigText(text: cart.total.toStringAsFixed(2)),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            cart.total > 3000
                ? const BigText(text: 'save -15%')
                : cart.total > 1000
                    ? const BigText(text: 'delivery')
                    : const BigText(text: 'delivery'),
            BigText(text: promotions.toStringAsFixed(2))
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
            onTap: () => cart.clear(),
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
