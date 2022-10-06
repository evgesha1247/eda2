import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/big_text.dart';

import '../../../object/dish_object.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeAppColor.kFrontColor,
      body: Column(
        children: const [
          _HeaderFavoritWidget(),
          _GridViewWidget(),
        ],
      ),
    );
  }
}

class _HeaderFavoritWidget extends StatelessWidget {
  const _HeaderFavoritWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BigText(text: 'Favorites'),
          Icon(Icons.favorite_border_outlined,
              color: ThemeAppColor.kAccent, size: 20)
        ],
      ),
    );
  }
}

class _GridViewWidget extends StatelessWidget {
  const _GridViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<DishModel>().itemsFovarit;
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: ThemeAppColor.kBGColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: GridView.custom(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            pattern: [
              const WovenGridTile(1),
              const WovenGridTile(5 / 7, crossAxisRatio: .9)
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: itemsFovarit.length,
            (context, index) => _ItemFovaritContainerWidget(index: index),
          ),
        ),
      ),
    );
  }
}

class _ItemFovaritContainerWidget extends StatelessWidget {
  const _ItemFovaritContainerWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(),
          color: ThemeAppColor.kFrontColor),
      child: _ItemFovaritContainerImgWidget(index: index),
    );
  }
}

class _ItemFovaritContainerImgWidget extends StatelessWidget {
  const _ItemFovaritContainerImgWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<DishModel>().itemsFovarit;
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ThemeAppColor.kAccent2,
                borderRadius: ThemeAppFun.decoration(),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 33, 36, 54),
                    offset: Offset(1, 3),
                    spreadRadius: .1,
                    blurRadius: 5,
                  )
                ]),
            child: Image(
                image: AssetImage(itemsFovarit[index].imgUrl),
                fit: BoxFit.contain,
                alignment: Alignment.center),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: BigText(text: itemsFovarit[index].name),
        ),
      ],
    );
  }
}
