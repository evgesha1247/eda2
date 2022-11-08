import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:text/app/model/menu/menu_model.dart';
import 'package:text/app/routes/main_screens.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../data/object/dish_object.dart';
import '../../theme/theme_app.dart';
import '../cart/cart_model.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? const [
                _HederWidget(),
                _FilterMenuWidget(),
                _MenuBodyWidget(),
              ]
            : [const _MenuBodyWidget()],
      ),
    );
  }
}

class _FilterMenuWidget extends GetView<MenuModel> {
  const _FilterMenuWidget();
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
    Widget itemFilterBtn({required int index}) {
      return GestureDetector(
        onTap: () => controller.filter(dishCategory: _dishCategory[index]),
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: ThemeAppFun.decoration(radius: 12),
              color: ThemeAppColor.kFrontColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(_icon[index], color: ThemeAppColor.kBGColor),
                SmallText(
                  text: _dishCategory[index],
                  size: ThemeAppSize.kFontSize16,
                  color: ThemeAppColor.kBGColor,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox(
        height: ThemeAppSize.kMenuFilter,
        child: ListView.builder(
          prototypeItem: SizedBox(
            width: ThemeAppSize.kNebuFilterItemContaiter,
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
    return GetBuilder<MenuModel>(
      init: MenuModel(),
      builder: (c) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 346.0,
          mainAxisExtent: 235,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: c.itemsFilter.length,
          (_, int index) => Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            child: _CartItemWidget(index: index),
          ),
        ),
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  const _CartItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = Get.find<MenuModel>();
    final itemImgUrl = model.itemsFilter[index].imgUrl;
    return GestureDetector(
      onTap: () => model.showDetail(model.itemsFilter[index]),
      child: Stack(children: [
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
      ]),
    );
  }
}

class _CartItemContainerWidget extends StatelessWidget {
  const _CartItemContainerWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        decoration: BoxDecoration(
          color: ThemeAppColor.kFrontColor,
          borderRadius: ThemeAppFun.decoration(),
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
    final model = Get.find<MenuModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: model.itemsFilter[index].isFavorit
              ? const Icon(Icons.favorite, color: ThemeAppColor.kBGColor)
              : const Icon(Icons.favorite_border, color: Colors.grey),
          onTap: () => model.toggFovarit(model.itemsFilter[index]),
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
    final item = Get.find<MenuModel>().itemsFilter[index];
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
          const SizedBox(height: 3),
          const Divider(
            color: Colors.grey,
            thickness: .5,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 3),
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

class _HederWidget extends StatelessWidget {
  const _HederWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      leading: SizedBox.shrink(),
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: ThemeAppColor.kFrontColor,
      flexibleSpace: _SearchWidget(),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius20)),
      borderSide: const BorderSide(style: BorderStyle.none),
    );
    final controller = Get.find<MenuModel>();
    return FlexibleSpaceBar(
      centerTitle: true,
      titlePadding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
      title: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: ThemeAppSize.width),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 33,
                  child: TextField(
                    cursorColor: ThemeAppColor.kFrontColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      filled: true,
                      fillColor: ThemeAppColor.kBGColor,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ThemeAppColor.kFrontColor,
                      ),
                      hintText: 'Search',
                      enabledBorder: styleSearch,
                      focusedBorder: styleSearch,
                    ),
                    onChanged: (text) {
                      controller.searchFilter(text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: ThemeAppSize.kInterval12),
            const _ButtonToCartWidget(),
          ],
        ),
      ),
    );
  }
}

class _ButtonToCartWidget extends StatelessWidget {
  const _ButtonToCartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final styleBut = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(
        width: 2,
        color: ThemeAppColor.kBGColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeAppFun.decoration(),
      ),
    );
    final number = Get.find<CartModel>().number();
    return Stack(children: [
      ElevatedButton(
        style: styleBut,
        onPressed: () => Get.toNamed(MainRoutes.cart),
        child: const SizedBox(
          height: 33,
          child: Icon(
            Icons.shopping_cart,
            color: ThemeAppColor.kBGColor,
          ),
        ),
      ),
      number != 0
          ? Positioned(
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: ThemeAppFun.decoration(radius: 15),
                ),
                child: Center(
                  child: GetBuilder<CartModel>(
                    builder: (c) {
                      return BigText(
                        text: c.number().toString(),
                        color: ThemeAppColor.kBGColor,
                      );
                    },
                  ),
                ),
              ),
            )
          : const SizedBox.shrink()
    ]);
  }
}
