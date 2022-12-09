import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_controller.dart';

class SplashController {

  Future<void> loadData() async {
    print('init spalash');

    // // global
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList().then(
          (value) => Get.offAllNamed(MainRoutes.getGuiding),
        );
    // // local
    Get.find<CartController>().getItemsListLocal();
    Get.find<FavoriteController>().getItemsListLocal();
  }




}
