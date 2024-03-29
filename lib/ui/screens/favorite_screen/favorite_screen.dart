import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/favorite_screen/favorite_model.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';


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
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BigText(
            text: 'Favorites',
            color: ThemeAppColor.kBGColor,
          ),
          Icon(
            Icons.favorite_border_outlined,
            color: ThemeAppColor.kBGColor,
            size: ThemeAppSize.kFontSize22,
          )
        ],
      ),
    );
  }
}

class _GridViewWidget extends StatelessWidget {
  const _GridViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<FavoriteModel>().itemsFovarit;
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
            (context, index) => _itemFovaritContainerWidget(
              index: index,
              name: itemsFovarit[index].name,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemFovaritContainerWidget({
    required int index,
    required String name,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(),
          color: ThemeAppColor.kFrontColor),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(child: _ItemFovaritContainerImgWidget(index: index)),
          Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            child: SmallText(text: name, maxLines: 2),
          ),
        ],
      ),
    );
  }
}

class _ItemFovaritContainerImgWidget extends StatelessWidget {
  const _ItemFovaritContainerImgWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemsFovarit = context.watch<FavoriteModel>().itemsFovarit;
    return Image(
      image: AssetImage(itemsFovarit[index].imgUrl),
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}
