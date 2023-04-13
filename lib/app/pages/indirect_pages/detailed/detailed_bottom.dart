import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class BottomDetailed extends StatelessWidget {
  const BottomDetailed({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kDetaildButtomContainer,
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius18 * 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AddAndSubProductWidget(item: item),
          _TotalPriceWidget(item: item),
        ],
      ),
    );
  }
}

class _TotalPriceWidget extends StatelessWidget {
  _TotalPriceWidget({required this.item});
  final ProductModel item;
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getCart),
      child: GetBuilder<CartController>(
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            decoration: BoxDecoration(
              color: _.totalItems > 0
                  ? context.theme.primaryColor
                  : context.theme.hintColor,
              borderRadius: ThemeAppFun.decoration(
                radius: ThemeAppSize.kRadius12,
              ),
            ),
            child: BigText(
              text: '\$ ${_.totalAmount} | ${'go_to_cart'.tr}',
              color: ThemeAppColor.kBGColor,
              size: ThemeAppSize.kFontSize20,
            ),
          );
        },
      ),
    );
  }
}

class _AddAndSubProductWidget extends StatelessWidget {
  const _AddAndSubProductWidget({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>()
        .initCountToCart(item, Get.find<CartController>());
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: ThemeAppFun.decoration(
          radius: ThemeAppSize.kRadius12,
        ),
      ),
      child: Row(
        children: [
          GetBuilder<ProductController>(
            builder: (_) => GestureDetector(
              onTap: () {
                _.upDataCountProductInCart(false, item);
              },
              child: Icon(
                Icons.remove,
                color: context.theme.hintColor,
              ),
            ),
          ),
          SizedBox(width: ThemeAppSize.kInterval5),
          GetBuilder<CartController>(
            builder: (_) => SmallText(
              text: '${_.getCountProduct(item)}',
              color: context.theme.hintColor,
            ),
          ),
          SizedBox(width: ThemeAppSize.kInterval5),
          GetBuilder<ProductController>(
            builder: (_) => GestureDetector(
              onTap: () => _.upDataCountProductInCart(true, item),
              child: Icon(
                Icons.add,
                color: context.theme.hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
