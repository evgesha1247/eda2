import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../controllers/product_controller.dart';
import '../../routes/main_routes.dart';
import '../../../helper/dependencies.dart' as dep;


class SplashModel extends GetxController {
  @override
  void onInit() {
    _showHome();
    _loadData();
    super.onInit();
  }
  Future<void> _loadData() async {

    await dep.initPageModel();
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList();
    await Hive.initFlutter();
  }

  void _showHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () => Get.offAllNamed(MainRoutes.getMain()),
    );
  }
}
