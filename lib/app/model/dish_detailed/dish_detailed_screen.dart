import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/icon/my_icon.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../widgets/text/expandable_text.dart';
import '../cart/cart_model.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatelessWidget {
  const DishDetailedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _DishDetailedBody(),
      bottomNavigationBar: _DishDetailedBottomBarWidget(),
    );
  }
}

class _DishDetailedBody extends StatelessWidget {
  const _DishDetailedBody();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DishDetailedModel());
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: ThemeAppColor.kFrontColor,
          expandedHeight: 280,
          toolbarHeight: 120,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => controller.showBack(),
                child: const MyIcon(icon: Icons.arrow_back_ios_new),
              ),
              GetBuilder<DishDetailedModel>(
                init: DishDetailedModel(),
                builder: (c) => GestureDetector(
                  onTap: () => c.toggFovarit(),
                  child: c.dish?.isFavorit == true
                      ? const MyIcon(
                          icon: Icons.favorite,
                          iconColor: ThemeAppColor.kAccent,
                        )
                      : const MyIcon(icon: Icons.favorite_border),
                ),
              ),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: GetBuilder<DishDetailedModel>(
              builder: (c) => Image.asset(
                c.dish?.imgUrl ?? ThemeAppImgURL.imgURL1,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeAppColor.kBGColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ThemeAppSize.kRadius20 * 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
                  child: GetBuilder<DishDetailedModel>(
                    builder: (c) => BigText(
                      text: c.dish?.name ?? '404',
                      color: ThemeAppColor.kFrontColor,
                      size: ThemeAppSize.kFontSize25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BigText(
                  text: 'Introduce',
                  color: ThemeAppColor.kFrontColor,

                ),
                SizedBox(
                  //    height: MediaQuery.of(context).size.height / 1.7,
                  child: GetBuilder<DishDetailedModel>(
                    builder: (c) => ExpandableTextWidget(
                      text: c.dish?.description ?? '404',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DishDetailedBottomBarWidget extends GetView<DishDetailedModel> {
  const _DishDetailedBottomBarWidget();
  @override
  Widget build(BuildContext context) {
    final cartModel = Get.put(CartModel());
    final controller = Get.put(DishDetailedModel());
    final dishkey = controller.dish?.id ?? '';
    final number = cartModel.namber(dishkey);
    final subTotal = cartModel.subTotal(dishkey).toStringAsFixed(1);
    return Container(
      height: ThemeAppSize.kDetaildButtomContainer,
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius20 * 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            decoration: BoxDecoration(
              color: ThemeAppColor.kBGColor,
              borderRadius: ThemeAppFun.decoration(
                radius: ThemeAppSize.kRadius12,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => cartModel.updataSubOne(dishkey),
                  child: const Icon(
                    Icons.remove,
                    color: ThemeAppColor.kFrontColor,
                  ),
                ),
                SizedBox(width: ThemeAppSize.kInterval5),
                SmallText(
                  text: '$number',
                  color: ThemeAppColor.kFrontColor,
                ),
                SizedBox(width: ThemeAppSize.kInterval5),
                GestureDetector(
                  onTap: () => cartModel.addItem(
                      dishId: controller.dish?.id,
                      price: controller.dish?.price,
                      name: controller.dish?.name,
                      imgUrl: controller.dish?.imgUrl),
                  child: const Icon(
                    Icons.add,
                    color: ThemeAppColor.kFrontColor,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.showCart(),
            child: Container(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              decoration: BoxDecoration(
                color: ThemeAppColor.kAccent,
                borderRadius: ThemeAppFun.decoration(
                  radius: ThemeAppSize.kRadius12,
                ),
              ),
              child: Row(
                children: [
                  SmallText(
                    text: '\$ $subTotal | ',
                    color: ThemeAppColor.kWhite,
                  ),
                  BigText(
                    text: 'Go to cart',
                    color: ThemeAppColor.kWhite,
                    size: ThemeAppSize.kFontSize20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
