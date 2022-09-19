import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/cart_object.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final items = cart.cartItem;
    return Center(
      child: ListView.builder(
        itemCount: cart.cartItem.length,
        itemBuilder: (context, index) {
          final name = items.values.elementAt(index).name;
          return Container(
            width: double.infinity,
            height: 50,
            color: Colors.red[100],
            child: Center(
              child: Text(name),
            ),
          );
        },
      ),
    );
  }
}
