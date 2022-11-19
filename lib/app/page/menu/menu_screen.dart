import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/anumated_icon_favorit.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                const _HederWidget(),
                // const _FilterMenuWidget(),
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
        onChanged: (text) {},
      ),
    );
  }
}

class _ButtonToCartWidget extends StatelessWidget {
  const _ButtonToCartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getCart()),
      child: const Icon(
        Icons.grid_view,
        size: 30,
        color: ThemeAppColor.kFrontColor,
      ),
    );
  }
}

// class _FilterMenuWidget extends GetView<MenuModel> {
//   const _FilterMenuWidget();
//   static const _icon = [
//     Icons.cookie,
//     Icons.local_drink,
//     Icons.restaurant_menu_rounded,
//     Icons.restore_outlined,
//   ];
//   static const _dishCategory = <String>[
//     DishCategory.dessert,
//     DishCategory.drinkables,
//     DishCategory.mainCourse,
//     'reset'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var defaultChoiceIndex = (_dishCategory.length - 1).obs;
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: EdgeInsets.all(
//           ThemeAppSize.kInterval12,
//         ),
//         child: Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: List.generate(
//             _dishCategory.length,
//             (index) {
//               return Obx(
//                 () => FilterChip(
//                   showCheckmark: false,
//                   avatar: Icon(_icon[index],
//                       color: index == defaultChoiceIndex.value
//                           ? ThemeAppColor.kAccent
//                           : Colors.grey),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                       ThemeAppSize.kInterval12,
//                     ),
//                   ),
//                   backgroundColor: Colors.white,
//                   padding: EdgeInsets.all(ThemeAppSize.kInterval12),
//                   label: SmallText(
//                       text: _dishCategory[index],
//                       size: ThemeAppSize.kFontSize14,
//                       color: index == defaultChoiceIndex.value
//                           ? ThemeAppColor.kAccent
//                           : Colors.grey),
//                   onSelected: (bool value) {
//                     defaultChoiceIndex.value =
//                         value ? index : defaultChoiceIndex.value;
//                     controller.filter(
//                       dishCategory: _dishCategory[defaultChoiceIndex.value],
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class _MenuBodyWidget extends StatelessWidget {
  const _MenuBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350.0,
        mainAxisExtent: 200,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (_, int index) => Padding(
          padding: EdgeInsets.only(
            left: ThemeAppSize.kInterval12,
            bottom: ThemeAppSize.kInterval24,
            right: ThemeAppSize.kInterval12,
          ),
          child: _CardItem(index: index),
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Stack(
        children: [
          /// img
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeAppColor.kFrontColor,
              borderRadius: ThemeAppFun.decoration(),
              image: const DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.7,
                image: AssetImage(ThemeAppImgURL.imgURLPromo1),
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
                  child: const BigText(
                    text: '\$price',
                    color: ThemeAppColor.kBGColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedIconWidget(
                        currIndex: 1.obs,
                        fun: () {},
                        widget1: const Icon(Icons.done),
                        widget2: const Icon(Icons.add),
                      ),
                      AnimatedIconWidget(
                        currIndex: 1.obs,
                        fun: () {},
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
