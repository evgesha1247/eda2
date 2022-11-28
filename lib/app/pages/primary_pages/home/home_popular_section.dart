import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/routes/main_routes.dart';

import '../../../../utils/app_constants.dart';
import '../../../controllers/favorite_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/products_model.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/load/circular.dart';
import '../../../widgets/text/my_text.dart';

class HomePopular extends StatelessWidget {
  const HomePopular({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ThemeAppSize.kInterval12),
        const _PopularTitle(),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _ProductBody(),
      ],
    );
  }
}

class _PopularTitle extends StatelessWidget {
  const _PopularTitle();
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        child: BigText(
          text: 'Popular product',
          color: ThemeAppColor.kFrontColor,
          size: ThemeAppSize.kFontSize20,
        ),
      );
}

class _ProductBody extends StatefulWidget {
  const _ProductBody({Key? key}) : super(key: key);
  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  var _currPageValue = 0.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kHomePageViewImg;
  final pageController = PageController(viewportFraction: .8, initialPage: 0);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        Get.find<ProductController>()
            .initFavoriteController(Get.find<FavoriteController>());
        _currPageValue = pageController.page!;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget _itemImg(ProductModel product) => Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    ThemeAppFun.decoration(radius: ThemeAppSize.kRadius20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${AppConstansts.BASE_URL}/uploads/${product.img!}"),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  stops: [0.3, .9],
                ),
                borderRadius: ThemeAppFun.decoration(
                  radius: ThemeAppSize.kRadius20,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(ThemeAppSize.kInterval24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BigText(
                            rightToLeft: true,
                            text: product.name!,
                            size: ThemeAppSize.kFontSize20 * 1.3,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );






  //             //   добавить
  //             GetBuilder<CartController>(
  //               builder: (controller) {
  //                 return AnimatedIconWidget(
  //                   currIndex:
  //                       (controller.existInCart(product) ? 0 : 1).obs,
  //                   fun: () => controller.addOneInCart(product),
  //                   widget1: CustomButtonIcon(
  //                     statusBorder: true,
  //                     colorBorder: Colors.green,
  //                     size: ThemeAppSize.kInterval5,
  //                     child: const Icon(Icons.done, color: Colors.green),
  //                   ),
  //                   widget2: CustomButtonIcon(
  //                     size: ThemeAppSize.kInterval5,
  //                     child:
  //                         const Icon(Icons.add, color: ThemeAppColor.grey),
  //                   ),
  //                 );
  //               },
  //             ),

  //             // добавть
  //             GetBuilder<FavoriteController>(
  //               builder: (controller) {
  //                 return AnimatedIconWidget(
  //                   currIndex:
  //                       (controller.existInFavorites(product) ? 0 : 1).obs,
  //                   fun: () => controller.upDataFavoriteList(product),
  //                   widget1: CustomButtonIcon(
  //                     statusBorder: true,
  //                     colorBorder: ThemeAppColor.kAccent,
  //                     size: ThemeAppSize.kInterval5,
  //                     child: const Icon(Icons.favorite,
  //                         color: ThemeAppColor.kAccent),
  //                   ),
  //                   widget2: CustomButtonIcon(
  //                     size: ThemeAppSize.kInterval5,
  //                     child: const Icon(Icons.favorite_outline,
  //                         color: ThemeAppColor.grey),
  //                   ),
  //                 );
  //               },
  //             ),


  Widget _builderItem(int index, ProductModel product) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactore + (_currPageValue - index + 1) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactore) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () =>
            Get.toNamed(MainRoutes.getDetailed(product.id), arguments: product),
        child: Stack(
          children: [
            _itemImg(product),

            //  _itemInfoBlok(product),
          ],
        ),
      ),
    );
  }

  Widget _botsIndicator() {
    return GetBuilder<ProductController>(
      builder: (popularProduct) => popularProduct.isLoadedPopular
          ? DotsIndicator(
              dotsCount: popularProduct.popularProductList.isEmpty
                  ? 1
                  : popularProduct.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                spacing: EdgeInsets.symmetric(
                  horizontal: ThemeAppSize.kInterval12,
                  vertical: ThemeAppSize.kInterval5,
                ),
                activeColor: ThemeAppColor.kAccent,
                color: ThemeAppColor.kFrontColor,
                activeSize: const Size(25.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<ProductController>(
          builder: (popularProduct) => popularProduct.isLoadedPopular
              ? SizedBox(
                  height: ThemeAppSize.kHomePageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProduct.popularProductList.length,
                    itemBuilder: (context, index) => _builderItem(
                      index,
                      popularProduct.popularProductList[index],
                    ),
                  ),
                )
              : const CircularWidget(),
        ),
        _botsIndicator(),
      ],
    );
  }
}
