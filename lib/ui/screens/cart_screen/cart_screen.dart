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
          padding: const EdgeInsets.all(ThemeApp.kInterval),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: _CartButtonBack(),
                  ),
                  BigText(text: 'Cart')
                ],
              ),
              const SizedBox(height: ThemeApp.kInterval),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItem.length,
                  itemBuilder: (context, index) {
                    return _CartRows(index: index);
                  },
                ),
              ),
              const SizedBox(height: ThemeApp.kInterval),
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
      padding: const EdgeInsets.only(bottom: ThemeApp.kInterval),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              spacing: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
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
            borderRadius: ThemeApp.decoration(),
            color: ThemeApp.kFrontColor,
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
        padding: const EdgeInsets.all(ThemeApp.kInterval),
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
        color: ThemeApp.kFrontColor,
        borderRadius: ThemeApp.decoration(),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: ThemeApp.kInterval,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: 'sub-total'),
              BigText(text: cart.total.toStringAsFixed(2)),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            cart.total > 3000
                ? BigText(text: 'save -15%')
                : cart.total > 1000
                    ? BigText(text: 'delivery')
                    : BigText(text: 'delivery'),
            BigText(text: promotions.toStringAsFixed(2))
          ]),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
            child: Divider(
              color: ThemeApp.kWhite,
              thickness: .3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: 'all total'),
              BigText(text: (cart.total + promotions).toString()),
            ],
          ),
          const SizedBox(height: ThemeApp.kInterval),
          GestureDetector(
            onTap: () => cart.clear(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeApp.kAccent,
                borderRadius: ThemeApp.decoration(),
              ),
              child: Center(
                child: BigText(text: 'add to cart'),
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
          borderRadius: ThemeApp.decoration(),
          color: ThemeApp.kFrontColor,
        ),
        padding: const EdgeInsets.only(
          top: ThemeApp.kInterval,
          bottom: ThemeApp.kInterval,
          left: ThemeApp.kInterval + 10,
          right: ThemeApp.kInterval,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeApp.kAccent,
        ),
      ),
    );
  }
}
