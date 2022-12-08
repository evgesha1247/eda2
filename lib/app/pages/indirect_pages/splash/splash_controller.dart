import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../routes/main_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _showHome();
    _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    // global
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList();
    // local
    Get.find<CartController>().getItemsListLocal();
    Get.find<FavoriteController>().getItemsListLocal();
  }

  void _showHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () => Get.offAllNamed(MainRoutes.getMain()),
    );
  }
}
