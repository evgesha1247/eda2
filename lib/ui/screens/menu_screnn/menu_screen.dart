import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:text/object/dish_object.dart';
import 'package:text/ui/screens/menu_screnn/manu_model.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../theme/theme_app.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                ScreensFactory().makeHeder(),
                const FilterMenuWidget(),
                const _MenuBodyWidget(),
              ]
            : [const _MenuBodyWidget()],
      ),
    );
  }
}

class FilterMenuWidget extends StatelessWidget {
  const FilterMenuWidget({super.key});
  static const _icon = [
    MdiIcons.foodCroissant,
    MdiIcons.glassTulip,
    MdiIcons.foodDrumstick,
    MdiIcons.restore,
  ];
  static const _dishCategory = [
    DishCategory.dessert,
    DishCategory.drinkables,
    DishCategory.mainCourse,
    'reset'
  ];
  @override
  Widget build(BuildContext context) {
    final model = context.read<MenuModel>();
    Widget itemFilterBtn({required int index}) {
      return GestureDetector(
        onTap: () => model.filter(dishCategory: _dishCategory[index]),
        child: Container(
          margin: EdgeInsets.all(ThemeAppSize.kInterval12),
          decoration: BoxDecoration(
              borderRadius: ThemeAppFun.decoration(radius: 12),
              color: ThemeAppColor.kBGColor,
              boxShadow: const [
                BoxShadow(
                  color: ThemeAppColor.kFrontColor,
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                  spreadRadius: .3,
                ),
                BoxShadow(
                  color: ThemeAppColor.kBGColor,
                  offset: Offset(-2, 0),
                  blurRadius: 5.0,
                  spreadRadius: .3,
                ),
                BoxShadow(
                  color: ThemeAppColor.kBGColor,
                  offset: Offset(2, 0),
                  blurRadius: 5.0,
                  spreadRadius: .3,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_icon[index]),
              SmallText(
                text: _dishCategory[index],
                color: ThemeAppColor.kFrontColor,
                size: ThemeAppSize.kFontSize16,
              )
            ],
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox(
        height: ThemeAppSize.kMenuFilter + 30,
        child: ListView.builder(
          prototypeItem: SizedBox(
            width: MediaQuery.of(context).size.width / _dishCategory.length,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: _dishCategory.length,
          itemBuilder: (BuildContext context, int index) => itemFilterBtn(
            index: index,
          ),
        ),
      ),
    );
  }
}

class _MenuBodyWidget extends StatelessWidget {
  const _MenuBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final length = context.watch<MenuModel>().itemsFilter.length;
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
    final model = context.read<MenuModel>();
    final itemImgUrl = model.itemsFilter[index].imgUrl;
    return GestureDetector(
        onTap: () => model.showDetail(context, model.itemsFilter[index]),
        child: Stack(
          children: (mediaQuery >= 370)
              ? [
                  _CartItemContainerWidget(index: index),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
    final itemImgUrl = context.read<MenuModel>().itemsFilter[index].imgUrl;
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
    final model = context.watch<MenuModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: model.itemsFilter[index].isFavorit
              ? const Icon(Icons.favorite, color: ThemeAppColor.kBGColor)
              : const Icon(Icons.favorite_border, color: Colors.grey),
          onTap: () => model.toggFovarit(index),
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
    final item = context.read<MenuModel>().itemsFilter[index];
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BigText(text: item.name),
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
      ),
    );
  }
}
