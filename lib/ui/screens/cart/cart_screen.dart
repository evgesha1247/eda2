import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/cart_object.dart';
import 'package:text/ui/theme/theme_app.dart';
import '../menu_screnn/menu_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
        child: Column(
          children: [
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
    return Padding(
      padding: const EdgeInsets.only(bottom: ThemeApp.kInterval),
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
    // final modelMenu = context.watch<MenuModel>();
    final name = cart.cartItem.values.elementAt(index).name;
    final price = cart.cartItem.values.elementAt(index).price.toString();
    final number = cart.cartItem.values.elementAt(index).number.toString();
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(ThemeApp.kInterval),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: ThemeApp.style(size: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price.toString(), style: ThemeApp.style(size: 22)),
                Text('ₓ$number', style: ThemeApp.style(size: 22)),
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
    final total = (cart.subTotal + cart.delivery).toStringAsFixed(2);
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
              Text(cart.subTotal.toStringAsFixed(2), style: ThemeApp.style()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: cart.subTotal == 0
                ? []
                : [
                    Text('delivery ', style: ThemeApp.style()),
                    Text(cart.delivery.toString(), style: ThemeApp.style()),
                  ],
          ),
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
              cart.subTotal == 0
                  ? Text('0', style: ThemeApp.style())
                  : Text(total, style: ThemeApp.style()),
            ],
          ),
          const SizedBox(height: ThemeApp.kInterval),
          GestureDetector(
            onTap: () {},
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
