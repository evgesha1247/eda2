import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/model/menu/menu_model.dart';
import 'package:text/app/routes/main_screens.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../data/object/dish_object.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/anumated_icon_favorit.dart';
import '../cart/cart_model.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                const _HederWidget(),
                _FilterMenuWidget(),
                const _MenuBodyWidget(),
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
  static const _dishCategory = <String>[
    DishCategory.dessert,
    DishCategory.drinkables,
    DishCategory.mainCourse,
    DishCategory.mainCourse,
    DishCategory.mainCourse,
    DishCategory.mainCourse,

    'reset'
  ];

  @override
  Widget build(BuildContext context) {
    var defaultChoiceIndex = (_dishCategory.length - 1).obs;
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            _dishCategory.length,
            (index) {
              return Obx(
                () => ChoiceChip(
                  label: Text(_dishCategory[index]),
                  selected: defaultChoiceIndex.value == index,
                  selectedColor: ThemeAppColor.kAccent,
                  onSelected: (value) {
                    defaultChoiceIndex.value =
                        value ? index : defaultChoiceIndex.value;
                    controller.filter(
                      dishCategory: _dishCategory[defaultChoiceIndex.value],
                    );
                  },
                ),
              );
            },
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
            child: _CardItem(index: index),
          ),
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final model = Get.find<MenuModel>();
  final cartModel = Get.find<CartModel>();
  _CardItem({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final item = model.itemsFilter[index];
    return GestureDetector(
      onTap: () => model.showDetail(model.itemsFilter[index]),
      child: Stack(
        children: [
          /// img
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeAppColor.kFrontColor,
              borderRadius: ThemeAppFun.decoration(),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.7,
                image: AssetImage(model.itemsFilter[index].imgUrl),
              ),
            ),

            /// content cart
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => AnimatedIconWidget(
                            currIndex:
                                (cartModel.cart[item] != null ? 0 : 1).obs,
                            fun: () => cartModel.addProduct(item),
                            widget1: const Icon(Icons.done),
                            widget2: const Icon(Icons.add),
                          )),
                      AnimatedIconWidget(
                        currIndex: (item.isFavorit ? 0 : 1).obs,
                        fun: () => model.toggFovarit(item),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
