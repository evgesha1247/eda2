import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/product_controller.dart';
import 'package:text/app/models/cart_model.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../utils/app_constants.dart';
import '../../routes/main_routes.dart';
import '../../widgets/icon/menu_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          _HeaderCart(),
          _CartBody(),
        ],
      ),
      bottomNavigationBar: const _Bottom(),
    );
  }
}

class _HeaderCart extends StatelessWidget {
  const _HeaderCart();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ThemeAppSize.kInterval12,
      left: ThemeAppSize.kInterval12,
      right: ThemeAppSize.kInterval12,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: CustomButtonIcon(
                sizePading: ThemeAppSize.kInterval12,
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: ThemeAppColor.kBGColor,
                ),
                bg: ThemeAppColor.kFrontColor,
              ),
            ),
          ),
          BigText(
            text: 'Cart',
            color: ThemeAppColor.kFrontColor,
            size: ThemeAppSize.kFontSize22,
          ),
        ],
      ),
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody();
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
                padding: EdgeInsets.zero,
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
                height: ThemeAppSize.kInterval24 * 9,
                width: ThemeAppSize.kInterval24 * 5,
                decoration: BoxDecoration(
                  color: ThemeAppColor.kFrontColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeAppSize.kRadius20),
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => controller.delite(item.product!),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ThemeAppColor.kAccent.withOpacity(0.3),
                      child: const CustomButtonIcon(
                        icon: Icon(
                          Icons.delete_outline_outlined,
                          color: ThemeAppColor.kBGColor,
                          size: 25,
                        ),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        color: ThemeAppColor.kBGColor,
        surfaceTintColor: ThemeAppColor.kBGColor,
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
                height: ThemeAppSize.kInterval24 * 10,
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
                padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                height: ThemeAppSize.kInterval24 * 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BigText(
                        text: item.name!,
                        maxLines: 3,
                        color: ThemeAppColor.kFrontColor,
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
              decoration: const BoxDecoration(
                color: ThemeAppColor.kFrontColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.all(ThemeAppSize.kInterval5),
              child: const Icon(Icons.close, color: ThemeAppColor.kBGColor),
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
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
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
            child: const Icon(
              Icons.remove,
              color: ThemeAppColor.kBGColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval5),
            child: SmallText(
              text: item.count.toString(),
              color: ThemeAppColor.kBGColor,
            ),
          ),
          GestureDetector(
            onTap: () =>
                productController.upDataCountProductInCart(true, item.product!),

            child: const Icon(
              Icons.add,
              color: ThemeAppColor.kBGColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.red,
      width: double.maxFinite,
      height: 100,
      child: Container(
        color: Colors.teal,
        child: GetBuilder<CartController>(
          builder: (_) {
            return Text('${_.totalAmount}');
          },
        ),
      ),
    );
  }
}
