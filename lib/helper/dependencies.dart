import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/api_client.dart';
import '../app/data/repository/auth_repo.dart';
import '../app/data/repository/favorite_repo.dart';
import '../app/data/repository/product_repo.dart';
import '../app/controllers/auth_controller.dart';
import '../app/pages/indirect_pages/splash/splash_controller.dart';
import '../app/controllers/menu_controller.dart';
import '../app/pages/primary_pages/guiding/guiding_controller.dart';
import '../app/theme/theme_controller.dart';
import '../utils/app_constants.dart';


class MainBindings implements Bindings {
  @override
  void dependencies() {
    //api
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstansts.BASE_URL));
    Get.lazyPut(() => AuthRepo());
  }
}


class GuidingBinding implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<GuidingController>(() => GuidingController());
    final sharedStore = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedStore);

    // menu
    Get.lazyPut(() => MenuController());

    ///

    Get.lazyPut(() => ThemeAppController.init);
    Get.lazyPut(() => FavoriteController(favoriteRepo: Get.find()));
    Get.lazyPut(() => FavoriteRepo(sharedStore: Get.find()));

    Get.lazyPut(
      () => ProductController(
        popularProductRepo: Get.find(),
        recommendedProductRepo: Get.find(),
      ),
    );
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

    Get.lazyPut(() => CartController(cartRepo: Get.find()));
    Get.lazyPut(() => CartRepo(sharedStore: Get.find()));
  }
}
