import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:text/object/cart_object.dart';
import 'package:text/ui/theme/theme_app.dart';

import '../../../object/dish_object.dart';
import '../dish_detailed_screen/dish_detailed_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(ThemeApp.kInterval),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _CartButtonBack(),
                  ),
                ),
                Text('Cart', style: ThemeApp.style(size: 20)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItem.length,
                itemBuilder: (context, index) {
                  return _CartRows(index: index);
                },
              ),
            ),
            const _BottnCart(),
          ],
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

    void doNothing(BuildContext context) {
      cartModel.delete(dishkey);
    }

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
          decoration: ThemeApp.decoration(),
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
            Text(cartItems.name, style: ThemeApp.style(size: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cartItems.price.toString(),
                    style: ThemeApp.style(size: 22)),
                Text('ₓ${cartItems.number}', style: ThemeApp.style(size: 22)),
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
      decoration: ThemeApp.decoration(),
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
              Text('sub-total  ', style: ThemeApp.style()),
              Text(cart.total.toStringAsFixed(2), style: ThemeApp.style()),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            cart.total > 3000
                ? Text('save -15%', style: ThemeApp.style())
                : cart.total > 1000
                    ? Text('delivery ', style: ThemeApp.style())
                    : Text('delivery ', style: ThemeApp.style()),
            Text(promotions.toStringAsFixed(2), style: ThemeApp.style())
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
              Text('all total ', style: ThemeApp.style()),
              Text((cart.total + promotions).toString(),
                  style: ThemeApp.style()),
            ],
          ),
          const SizedBox(height: ThemeApp.kInterval),
          GestureDetector(
            onTap: () => cart.clear(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
              width: double.infinity,
              decoration: ThemeApp.decoration(colors: ThemeApp.kAccent),
              child: Center(
                child: Text(
                  'add to cart',
                  style: ThemeApp.style(
                    colors: ThemeApp.kFrontColor,
                    fW: FontWeight.bold,
                  ),
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
        decoration: ThemeApp.decoration(),
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
