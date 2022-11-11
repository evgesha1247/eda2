
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/model/menu/menu_model.dart';
import 'package:text/app/routes/main_screens.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../data/object/dish_object.dart';
import '../../theme/theme_app.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? const [
                _HederWidget(),
                //_FilterMenuWidget(),
                _MenuBodyWidget(),
              ]
            : [const _MenuBodyWidget()],
      ),

    );
  }
}

class _HederWidget extends StatelessWidget {
  const _HederWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: ThemeAppColor.kBGColor,
      toolbarHeight: 50,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(
          horizontal: ThemeAppSize.kInterval12,
        ),
        title: Row(
          children: [
            const _SearchWidget(),
            SizedBox(width: ThemeAppSize.kInterval12),
            const _ButtonToCartWidget(),
          ],
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius20)),
      borderSide: const BorderSide(
        color: ThemeAppColor.kFrontColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    );
    final controller = Get.find<MenuModel>();
    return Expanded(
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
    );
  }
}

class _ButtonToCartWidget extends StatelessWidget {
  const _ButtonToCartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.homeCart),
      child: const Icon(
        Icons.grid_view,
        size: 30,
        color: ThemeAppColor.kFrontColor,
      ),
    );
  }
}

class _FilterMenuWidget extends GetView<MenuModel> {
  const _FilterMenuWidget();
  static const _icon = [
    Icons.aspect_ratio,
    Icons.aspect_ratio,
    Icons.aspect_ratio,
    Icons.aspect_ratio,
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
      builder: (c) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350.0,
          mainAxisExtent: 200,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: c.itemsFilter.length,
          (_, int index) => Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            child: _CartItem(index: index),
          ),
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = Get.find<MenuModel>();
    final item = model.itemsFilter[index];
    return GestureDetector(
      onTap: () => model.showDetail(model.itemsFilter[index]),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeAppColor.kFrontColor,
          borderRadius: ThemeAppFun.decoration(),
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.7,
            image: AssetImage(model.itemsFilter[index].imgUrl),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              decoration: BoxDecoration(
                color: ThemeAppColor.kFrontColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ThemeAppSize.kRadius12),
                  bottomLeft: Radius.circular(ThemeAppSize.kRadius20),
                ),
              ),
              child: BigText(
                text: '\$ ${item.price}',
                color: ThemeAppColor.kBGColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
