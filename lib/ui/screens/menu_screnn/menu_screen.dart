import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/widgets/big_text.dart';
import 'package:text/ui/widgets/small_text.dart';
import '../../../object/dish_object.dart';
import '../../theme/theme_app.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final factor = ScreensFactory();
    return Scaffold(
        body: CustomScrollView(
      slivers: mediaQuery >= 370
          ? [factor.makeHeder(), const _MenuBodyWidget()]
          : [const _MenuBodyWidget()],
    ));
  }
}

class _MenuBodyWidget extends StatelessWidget {
  const _MenuBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final length = context.watch<DishModel>().items.length;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 346.0,
        mainAxisExtent: 250,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: length,
        (_, int index) => _CartItemWidget(index: index),
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  const _CartItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final modelMenu = context.read<DishModel>();
    final itemImgUrl = modelMenu.items[index].imgUrl;
    return GestureDetector(
        onTap: () => modelMenu.showDetail(context, index),
        child: Stack(
          children: (mediaQuery >= 370)
              ? [
                  _CartItemContainerWidget(index: index),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      width: 90,
                      height: 90,
                      itemImgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]
              : [_CartItemContainerWidget(index: index)],
        ));
  }
}

class _CartItemContainerWidget extends StatelessWidget {
  const _CartItemContainerWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemImgUrl = context.read<DishModel>().items[index].imgUrl;
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        decoration: BoxDecoration(
          color: ThemeAppColor.kFrontColor,
          borderRadius: ThemeAppFun.decoration(),
          image: MediaQuery.of(context).size.width < 370
              ? DecorationImage(
                  image: AssetImage(itemImgUrl),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter)
              : null,
        ),
        child: _CartItemContainerContentWidget(index: index));
  }
}

class _CartItemContainerContentWidget extends StatelessWidget {
  const _CartItemContainerContentWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        children: [
          _ButtonFavoritWidget(index: index),
          _CartItemContainerTextWidget(index: index),
        ],
      ),
    );
  }
}

class _ButtonFavoritWidget extends StatelessWidget {
  const _ButtonFavoritWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final dishItem = context.watch<DishModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: dishItem.items[index].isFovarit
              ? const Icon(Icons.favorite, color: ThemeAppColor.kBGColor)
              : const Icon(Icons.favorite_border, color: Colors.grey),
          onTap: () => dishItem.toggFovarit(index),
        )
      ],
    );
  }
}

class _CartItemContainerTextWidget extends StatelessWidget {
  const _CartItemContainerTextWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final item = context.read<DishModel>().items[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: BigText(text: item.name),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SmallText(text: item.description),
            ),
            BigText(
              text: 'more',
              size: ThemeAppSize.kFontSize18,
              color: ThemeAppColor.kAccent,
            ),
          ],
        ),
        const Divider(color: Colors.grey, thickness: .3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BigText(text: 'price : '),
            BigText(text: '\$ ${item.price}'),
          ],
        ),
      ],
    );
  }
}
