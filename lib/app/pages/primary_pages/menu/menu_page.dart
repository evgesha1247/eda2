import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/controllers/menu_controller.dart';
import 'package:text/app/widgets/icon/custom_icon.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/favorite_controller.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                MenuHeader(),
                FilterWidget(),
                _MenuBodyWidget(),
              ]
            : [_MenuBodyWidget()],
      ),
    );
  }
}

class _MenuBodyWidget extends StatelessWidget {
  _MenuBodyWidget({Key? key}) : super(key: key);
  final controller = Get.find<MenuController>();
  SliverChildBuilderDelegate _delegat({required child}) {
    return SliverChildBuilderDelegate(
      childCount: controller.filterList.length,
      (_, int index) => Padding(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval24,
          right: ThemeAppSize.kInterval12,
        ),
        child: child(product: controller.filterList[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (_) => Container(
        child: _.isListGrid
            ? SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: _delegat(child: _cardItem))
            : SliverList(delegate: _delegat(child: _cardItem)),
      ),
    );
  }
}

Widget _cardItem({required ProductModel product}) {
  return GestureDetector(
    onTap: () =>
        Get.toNamed(MainRoutes.getDetailed(product.id), arguments: product),
    child: Stack(
      children: [
        _ItemImg(img: "${AppConstansts.BASE_URL}/uploads/${product.img!}"),
        _ItemControlElements(product: product),
      ],
    ),
  );
}

class _ItemControlElements extends StatelessWidget {
  const _ItemControlElements({required this.product});
  final ProductModel product;
  Widget _iconAdd() {
    return GetBuilder<CartController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.existInCart(product) ? 0 : 1).obs,
          fun: () => controller.addOneInCart(product),
          widget1: CustomButtonIcon(
            colorBorder: Colors.green,
            bg: ThemeAppColor.kFrontColor,
            size: ThemeAppSize.kInterval5,
            child: const Icon(Icons.done, color: Colors.green),
          ),
          widget2: CustomButtonIcon(
            size: ThemeAppSize.kInterval5,
            bg: ThemeAppColor.kFrontColor,
            child: const Icon(Icons.add, color: ThemeAppColor.kBGColor),
          ),
        );
      },
    );
  }

  Widget _iconFavorit() {
    return GetBuilder<FavoriteController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.existInFavorites(product) ? 0 : 1).obs,
          fun: () => controller.upDataFavoriteList(product),
          widget1: CustomButtonIcon(
            bg: ThemeAppColor.kFrontColor,
            colorBorder: ThemeAppColor.kAccent,
            size: ThemeAppSize.kInterval5,
            child: const Icon(Icons.favorite, color: ThemeAppColor.kAccent),
          ),
          widget2: CustomButtonIcon(
            bg: ThemeAppColor.kFrontColor,
            size: ThemeAppSize.kInterval5,
            child: const Icon(
              Icons.favorite_outline,
              color: ThemeAppColor.kBGColor,
            ),
          ),
        );
      },
    );
  }

  Widget _price() {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _price(),
          Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconAdd(),
                _iconFavorit(),
              ],
            ),
          )
        ]);
  }
}

class _ItemImg extends StatelessWidget {
  const _ItemImg({required this.img});
  final String img;
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
