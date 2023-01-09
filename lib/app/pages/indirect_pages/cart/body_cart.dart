// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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
              return constroller.getItemsList.isNotEmpty
                  ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: constroller.getItemsList.length,
                padding: const EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        return _RowItem(controller: constroller, index: index);
                      })
                  : Padding(
                      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                      child: Column(
                        children: [
                          Image.asset('assets/icons/cart.png'),
                        ],
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemInside extends StatelessWidget {
  _ItemInside({required this.item});
  final controller = Get.find<CartController>();
  final CartModel item;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Container(
          height: ThemeAppSize.kInterval24 * 5,
          width: ThemeAppSize.kInterval24 * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeAppSize.kRadius18),
            ),
            border: Border.all(color: context.theme.hintColor),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => controller.delite(item.product!),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.delete_outline_outlined,
                  color: context.theme.hintColor,
                  size: ThemeAppSize.kFontSize20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  _Item({required this.controller, required this.item});
  final CartController controller;
  final CartModel item;
  final height = ThemeAppSize.kInterval24 * 6;

  Widget _itemImg() {

    return GestureDetector(
      onTap: () {

        Get.toNamed(
          MainRoutes.getDetailed(item.product!.id),
          arguments: item.product!,
        );
      },
      // child:   Image(
      //   width: ThemeAppSize.kInterval24 * 5,
      //   height: height,
      //   fit: BoxFit.cover,
      //   image: NetworkImage(item.product!.img!.first),
      // ),
    );

  }

  Widget _infoItem() {
    return Expanded(
      child: Container(
        height: height,
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BigText(
                text: item.product!.name!,
                maxLines: 3,
                color: Get.context!.theme.accentColor,
                size: ThemeAppSize.kFontSize20,
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

              ],
            )
          ],
        ),
      ),
    );
  }


Widget _itemCloueIcon() {
    return Container(
              decoration: BoxDecoration(
        color: Get.context?.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
                ),
          border: Border.all(
            color: Get.context?.theme.cardColor as Color,
            width: 1.5,
          )
              ),
              padding: EdgeInsets.all(ThemeAppSize.kInterval5),
              child: Icon(
                Icons.close, color: Get.context?.theme.hintColor
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeAppSize.kRadius12),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        color: context.theme.cardColor,
        surfaceTintColor: Get.context?.theme.cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemImg(),
            _infoItem(),
            _itemCloueIcon(),
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.controller, required this.index});
  final CartController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    final item = controller.getItemsList[index];
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          _ItemInside(item: item),
        ],
      ),
      child: _Item(controller: controller, item: item),
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
      padding: EdgeInsets.all(ThemeAppSize.kInterval12 / 1.5),
      margin: EdgeInsets.only(
        top: ThemeAppSize.kInterval12,
        right: ThemeAppSize.kInterval12,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
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
              color: context.theme.hintColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval5),
            child: SmallText(
              text: item.count.toString(),
              color: context.theme.hintColor,
            ),
          ),
          GestureDetector(
            onTap: () =>
                productController.upDataCountProductInCart(true, item.product!),
            child: Icon(
              Icons.add,
              color: context.theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
