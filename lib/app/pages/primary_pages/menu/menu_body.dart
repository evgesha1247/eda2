import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/menu_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class MenuBodyWidget extends StatelessWidget {
  MenuBodyWidget({super.key});
  final controller = Get.find<MenuController>();

  SliverChildBuilderDelegate _builderItem({required productList}) {
    return SliverChildBuilderDelegate(
      childCount: controller.filterList.length,
      (_, int index) => Padding(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval24,
          right: ThemeAppSize.kInterval12,
        ),
        child: GestureDetector(
          onTap: () => Get.toNamed(
            MainRoutes.getDetailed(productList[index].id),
            arguments: productList[index],
          ),
          child: Stack(
            children: [
              _ItemImg(
                img:
                    "${AppConstansts.BASE_URL}/uploads/${productList[index].img!}",
              ),
              _ItemControlElements(product: productList[index]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (_) => Container(
        child: _.isListGrid
            ? SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 370,
                ),
                delegate: _builderItem(productList: controller.filterList),
              )
            : SliverList(
                delegate: _builderItem(productList: controller.filterList),
              ),
      ),
    );
  }
}

class _ItemImg extends StatelessWidget {
  final String img;
  const _ItemImg({required this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeAppColor.grey,
        borderRadius: ThemeAppFun.decoration(),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(img),
        ),
      ),
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
          decoration: BoxDecoration(
            color: ThemeAppColor.kFrontColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(ThemeAppSize.kRadius12),
              bottomLeft: Radius.circular(ThemeAppSize.kRadius20),
            ),
          ),
          child: BigText(
            text: '\$${product.price}',
            color: ThemeAppColor.kBGColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CartAddIcon(product: product),
              FavoritIcon(product: product)
            ],
          ),
        )
      ],
    );
  }
}
