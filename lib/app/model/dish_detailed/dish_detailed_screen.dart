import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/icon/menu_icon.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../widgets/text/expandable_text.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatelessWidget {
  const DishDetailedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _DishDetailedBody(),
      bottomNavigationBar: const _DishDetailedBottomBarWidget(),
    );
  }
}

class _DishDetailedBody extends StatelessWidget {
  final DishDetailedModel controller = Get.find();
  _DishDetailedBody();
  @override
  Widget build(BuildContext context) {
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
                onTap: () => Get.back(),
                child: const MenuButtonIcon(icon: Icons.arrow_back_ios_new),
              ),
              GestureDetector(
                  onTap: () => controller.toggFovarit(),
                  child: GetBuilder<DishDetailedModel>(
                    builder: (_) => MenuButtonIcon(
                      icon: controller.dish.isFavorit == true
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      colorIcon: controller.dish.isFavorit == true
                          ? ThemeAppColor.kAccent
                          : ThemeAppColor.kBGColor,
                    ),
                  )),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              controller.dish.imgUrl,
              width: double.maxFinite,
              fit: BoxFit.cover,
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
                  child: BigText(
                    text: controller.dish.name,
                    color: ThemeAppColor.kFrontColor,
                    size: ThemeAppSize.kFontSize25,
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
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ExpandableTextWidget(
                    text: controller.dish.description,
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

class _DishDetailedBottomBarWidget extends StatelessWidget {
  const _DishDetailedBottomBarWidget();
  @override
  Widget build(BuildContext context) {
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
          _AddAndSubDishWidget(),
          _TotalPriceWidget(),
        ],
      ),
    );
  }
}

class _TotalPriceWidget extends StatelessWidget {
  final controller = Get.find<DishDetailedModel>();
  _TotalPriceWidget();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              text: '0  | ',
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
    );
  }
}

class _AddAndSubDishWidget extends StatelessWidget {
  final controller = Get.find<DishDetailedModel>();

  _AddAndSubDishWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () => controller.sub(),
            child: const Icon(
              Icons.remove,
              color: ThemeAppColor.kFrontColor,
            ),
          ),
          SizedBox(width: ThemeAppSize.kInterval5),
          Obx(() => SmallText(
                text: controller.count,
                color: ThemeAppColor.kFrontColor,
              )),
          SizedBox(width: ThemeAppSize.kInterval5),
          GestureDetector(
            onTap: () => controller.add(),
            child: const Icon(
              Icons.add,
              color: ThemeAppColor.kFrontColor,
            ),
          )
        ],
      ),
    );
  }
}
