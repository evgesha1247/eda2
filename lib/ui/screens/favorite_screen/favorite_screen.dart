import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';

import '../../../object/dish_object.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeaderFavoritWidget(),
        SizedBox(height: ThemeApp.kHeight),
        _GridViewWidget(),
      ],
    );
  }
}

class _HeaderFavoritWidget extends StatelessWidget {
  const _HeaderFavoritWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ThemeApp.kFrontColor,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(ThemeApp.kInterval),
        child: Text(
          'Favorites',
          style: ThemeApp.style(
            colors: ThemeApp.kAccent,
            size: 20,
            fW: FontWeight.w500,
          ),
        ),
      )),
    );
  }
}

class _GridViewWidget extends StatelessWidget {
  const _GridViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<DishModel>().itemsFovarit;
    return Expanded(
      child: GridView.custom(
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
    );
  }
}

class _ItemFovaritContainerWidget extends StatelessWidget {
  const _ItemFovaritContainerWidget({Key? key, required this.index})
      : super(key: key);
  final index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
      ),
      child: _ItemFovaritContainerImgWidget(index: index),
    );
  }
}

class _ItemFovaritContainerImgWidget extends StatelessWidget {
  const _ItemFovaritContainerImgWidget({Key? key, required this.index})
      : super(key: key);
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
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 53, 56, 74),
                borderRadius: BorderRadius.all(
                  Radius.circular(ThemeApp.kRadius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 33, 36, 54),
                    offset: Offset(0, 3),
                    spreadRadius: .1,
                    blurRadius: 1,
                  )
                ]),
            child: Image(
                image: AssetImage(itemsFovarit[index].imgUrl),
                fit: BoxFit.contain,
                alignment: Alignment.center),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(ThemeApp.kInterval),
          child: Text(
            itemsFovarit[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ThemeApp.style(size: 20),
          ),
        ),
      ],
    );
  }
}
