import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/cart_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: ThemeAppSize.kInterval12 * 6.2,
          left: ThemeAppSize.kInterval12,
          right: ThemeAppSize.kInterval12,
          bottom: 0,
          child: GetBuilder<CartController>(
            builder: (constroller) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: constroller.getItemsList.length,
                padding: const EdgeInsets.only(bottom: 100),
                itemBuilder: (context, index) {
                  return _RowItem(controller: constroller, index: index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.controller, required this.index});
  final CartController controller;
  final int index;
  ActionPane _itemBack({required CartModel item}) => ActionPane(
        motion: const StretchMotion(),
        children: [
          Flexible(
            child: Center(
              child: Container(
                height: ThemeAppSize.kInterval24 * 5,
                width: ThemeAppSize.kInterval24 * 4,
                decoration: BoxDecoration(
                  color: Get.theme.backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeAppSize.kRadius20),
                  ),
                  border: Border.all(),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => controller.delite(item.product!),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.delete_outline_outlined,
                        color: Get.theme.cardColor,
                        size: ThemeAppSize.kFontSize22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
  Widget _item({required CartController controller, required CartModel item}) {
    final String total = (item.price! * item.count!).toString();
    final height = ThemeAppSize.kInterval24 * 8;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeAppSize.kRadius12),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        color: Get.theme.cardColor,
        surfaceTintColor: Get.theme.cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //// img
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  MainRoutes.getDetailed(item.product!.id),
                  arguments: item.product!,
                );
              },
              child: Container(
                width: ThemeAppSize.kInterval24 * 7,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "${AppConstansts.BASE_URL}/uploads/${item.img!}",
                    ),
                  ),
                ),
              ),
            ),

            /// info
            Expanded(
              child: Container(
                height: height,
                padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BigText(
                        text: item.name!,
                        maxLines: 3,
                        color: Get.theme.backgroundColor,
                        size: ThemeAppSize.kFontSize22,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _AddAndSubProductWidget(
                          item: item,
                          controller: controller,
                        ),
                        SizedBox(width: ThemeAppSize.kInterval12),
                        Text(total)
                      ],
                    )
                  ],
                ),
              ),
            ),

            /// close / delite
            Container(
              decoration: BoxDecoration(
                color: Get.theme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.all(ThemeAppSize.kInterval5),
              child: Icon(Icons.close, color: Get.theme.cardColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = controller.getItemsList[index];

    return Slidable(
      key: const ValueKey(0),
      endActionPane: _itemBack(item: item),
      child: _item(controller: controller, item: item),
    );
  }
}

class _AddAndSubProductWidget extends StatelessWidget {
  _AddAndSubProductWidget({required this.item, required this.controller});
  final CartModel item;
  final CartController controller;
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>()
        .initCountToCart(item.product!, Get.find<CartController>());
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: ThemeAppFun.decoration(
          radius: ThemeAppSize.kRadius12,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              productController.upDataCountProductInCart(false, item.product!);
            },
            child: Icon(
              Icons.remove,
              color: Theme.of(context).cardColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval5),
            child: SmallText(
              text: item.count.toString(),
              color: Theme.of(context).cardColor,
            ),
          ),
          GestureDetector(
            onTap: () =>
                productController.upDataCountProductInCart(true, item.product!),
            child: Icon(
              Icons.add,
              color: Theme.of(context).cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
