import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';

import '../../../object/dish_object.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<DishModel>().itemsFovarit;
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 10,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(
            5 / 7,
            crossAxisRatio: .9,
            alignment: AlignmentDirectional.center,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: itemsFovarit.length,
        (context, index) => ItemFovarit(index: index),
      ),
    );
  }
}

class ItemFovarit extends StatelessWidget {
  const ItemFovarit({Key? key, required this.index}) : super(key: key);
  final index;
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<DishModel>().itemsFovarit;
    return Container(
      decoration: BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
        image: DecorationImage(
            image: AssetImage(itemsFovarit[index].imgUrl),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter),
      ),
      // color: Colors.red,
    );
  }
}
