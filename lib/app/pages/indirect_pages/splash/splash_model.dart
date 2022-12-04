import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
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
    await dep.initPageConfig();
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList();
    //   Get.find<CartController>().getItemsListLocal();
  }

  void _showHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () => Get.offAllNamed(MainRoutes.getMain()),
    );
  }
}
