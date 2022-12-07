import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../../controllers/product_controller.dart';
import '../../../routes/main_routes.dart';
import '../../../../helper/dependencies.dart' as dep;

class SplashModel extends GetxController {
  @override
  void onInit() {
    _showHome();
    _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList();

    Get.find<ThemeAppController>().getThemeStatus();

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
