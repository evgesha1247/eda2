import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../object/cart_object.dart';
import '../../../object/dish_object.dart';

class ButtonFavoritWidget extends StatelessWidget {
  const ButtonFavoritWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final isFovarit = context.watch<DishModel>().items[index].isFovarit;
    final dishItem = context.watch<DishModel>().items[index];
    //  final modelMenu = context.watch<MenuModel>();
    final cart = context.read<CartModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Icon(
            Icons.favorite_border_sharp,
            color: isFovarit ? Colors.red : Colors.grey,
          ),
          onTap: () {
            cart.addItem(
              dishId: dishItem.id,
              price: dishItem.price,
              name: dishItem.name,
              imgUrl: dishItem.imgUrl,
            );
          },
        )
      ],
    );
  }
}
