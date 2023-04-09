// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/menu_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon.dart';
import '../../../widgets/text/my_text.dart';
import '../guiding/controller/guiding_controller.dart';
import 'model/filter_model.dart';

class BodyMenu extends StatelessWidget {
  const BodyMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
      builder: (MenuControll controller) {
        switch (controller.renderingMethod) {
          case RenderingMethod.grid:
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: ThemeAppSize.kMaxMinWidth - 1,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                  childCount: controller.filterList.length,
                  (_, int index) => _ItemBuilderGrid(
                        item: controller.filterList[index],
                        index: index,
                      )
              ),
            );
          case RenderingMethod.list:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.filterList.length,
                (_, int index) => _ItemBuilderList(item: controller.filterList[index]),
              ),
            );
        }
      },
    );
  }
}
class ContentContainer extends StatelessWidget {
  final Widget child;
  const ContentContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ThemeAppSize.kInterval12,
        bottom: ThemeAppSize.kInterval24,
        right: ThemeAppSize.kInterval12,
      ),
      child: Material(
          elevation: 5,
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(ThemeAppSize.kRadius12),
          shadowColor: context.theme.cardColor,
          clipBehavior: Clip.hardEdge,
          child: child),
    );
  }
}
class _ItemBuilderGrid extends StatelessWidget {
  final ProductModel item;
  final int index;
  const _ItemBuilderGrid({required this.item, required this.index});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuidingController>();
    return Obx(
      () => AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 350 + (index * 300)),
        transform: Matrix4.translationValues(
          controller.startAnimationMenu.value
              ? 0
              : index % 2 == 0
                  ? -context.height
                  : context.height,
          0,
          0,
        ),
        child: ContentContainer(
            child: Stack(
              children: [
                _ItemImg(product: item),
                _ItemIcons(product: item),
              ],

          ),
        ),
      ),
    );
  }
}

class _ItemBuilderList extends StatelessWidget {
  final ProductModel item;
  const _ItemBuilderList({required this.item});
  @override
  Widget build(BuildContext context) {
    final size = ThemeAppSize.kHeight100 * 1.2;
    return ContentContainer(
        child: Row(
          children: [
            _ItemImg(product: item, w: size, h: size),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      _ItemName(name: item.name as String),
                    _ItemPrice(product: item),
                    ],
                  ),
                  Row(children: [_ItemButtoms(product: item)]),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

///////////////////////////
///// Item Components ////
//////////////////////////

class _ItemImg extends StatelessWidget {
  final ProductModel product;
  final double h;
  final double w;
  const _ItemImg({required this.product, this.h = 0, this.w = 0});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        MainRoutes.getDetailed(product.id),
        arguments: product,
      ),
      child: Hero(
        tag: '1${product.imgs?.first.imgURL}',
        child: Image(
          height: h == 0 ? double.infinity : h,
          width: w == 0 ? double.infinity : w,
          fit: BoxFit.cover,
          image: NetworkImage('${product.imgs?.first.imgURL}'),
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  final String name;
  const _ItemName({required this.name});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: ThemeAppSize.kInterval12),
            child: BigText(
              text: name,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemIcons extends StatelessWidget {
  final ProductModel product;
  const _ItemIcons({required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ItemPrice(product: product),
        _ItemButtoms(product: product),
      ],
    );
  }
}

class _ItemPrice extends StatelessWidget {
  final ProductModel product;
  const _ItemPrice({
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      margin: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(ThemeAppSize.kRadius12),
          bottomLeft: Radius.circular(ThemeAppSize.kRadius18),
        ),
      ),
      child: BigText(
        text: '\$${product.price}',
        color: context.theme.accentColor,
      ),
    );
  }
}

class _ItemButtoms extends StatelessWidget {
  final ProductModel product;
  const _ItemButtoms({required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartAddIcon(
            product: product,
            bg: context.theme.scaffoldBackgroundColor,
            iconColor: context.theme.hintColor,
          ),
          SizedBox(width: ThemeAppSize.kInterval12),
          FavoritIcon(
            product: product,
            bg: context.theme.scaffoldBackgroundColor,
            iconColor: context.theme.hintColor,
          )
        ],
      ),
    );
  }
}
