// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class MenuBody extends StatelessWidget {
  MenuBody({super.key});
  final controller = Get.find<MenuController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(builder: (MenuController controller) {
      return controller.listStatus == ListStatus.grid
          ? SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 370,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: controller.filterList.length,
                (_, int index) =>
                    _ItemBuilderGrid(item: controller.filterList[index]),
              ))
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.filterList.length,
                (_, int index) =>
                    _ItemBuilderList(item: controller.filterList[index]),
              ),
            );
    });
  }
}

class _ItemBuilderGrid extends StatelessWidget {
  final ProductModel item;
  const _ItemBuilderGrid({required this.item});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ThemeAppSize.kInterval12,
        bottom: ThemeAppSize.kInterval24,
        right: ThemeAppSize.kInterval12,
      ),
      child: Material(
        elevation: 8,
        shadowColor: context.theme.cardColor,
        borderRadius: BorderRadius.circular(ThemeAppSize.kRadius12),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          onTap: () => Get.toNamed(
            MainRoutes.getDetailed(item.id),
            arguments: item,
          ),
          child: Stack(
            children: [
              // _ItemImg(img: "${AppConstansts.BASE_URL}/uploads/${item.img!}"),
              _ItemControlElements(product: item),
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
    return Container(
        margin: const EdgeInsets.only(top: 10),
        width: 100,
        height: 100,
        color: Colors.orange);
  }
}

class _ItemImg extends StatelessWidget {
  final String img;
  const _ItemImg({required this.img});
  @override
  Widget build(BuildContext context) {
    return Image(
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      image: NetworkImage(img),
    );
  }
}

class _ItemControlElements extends StatelessWidget {
  final ProductModel product;
  const _ItemControlElements({required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          margin: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(ThemeAppSize.kRadius12),
              bottomLeft: Radius.circular(ThemeAppSize.kRadius18),
            ),

          ),
          child: BigText(
            text: '\$${product.price}',
            color: context.theme.hintColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CartAddIcon(
                product: product,
                bg: context.theme.scaffoldBackgroundColor,
                iconColor: context.theme.hintColor,
              ),
              FavoritIcon(
                product: product,
                bg: context.theme.scaffoldBackgroundColor,
                iconColor: context.theme.hintColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
