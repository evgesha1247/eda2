import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../object/dish_model.dart';

class ButtonFavoritWidget extends StatelessWidget {
  const ButtonFavoritWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final isFovarit = context.watch<DishModel>().items[index].isFovarit;
    //  final modelMenu = context.watch<MenuModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Icon(
            Icons.favorite_border_sharp,
            color: isFovarit ? Colors.red : Colors.grey,
          ),
          onTap: () => {},
        )
      ],
    );
  }
}
