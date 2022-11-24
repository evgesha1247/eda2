import 'package:flutter/material.dart';
import 'package:text/app/page/cart/body_cart.dart';
import 'bottom_cart.dart';
import 'header_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          CartHeader(),
          CartBody(),
          BottomCart(),
        ],
      ),

    );
  }
}
