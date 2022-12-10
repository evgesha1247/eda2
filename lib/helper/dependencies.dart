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

class ApiBindings implements Bindings {
  @override
  void dependencies() {
    print('api client init  /  lazy auth');
    //api
    Get.put(ApiClient(appBaseUrl: AppConstansts.BASE_URL));
    Get.lazyPut(() => AuthRepo());
  }
}

class ControllersBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    /// product
    Get.lazyPut(() => ProductController(
        popularProductRepo: Get.find(), recommendedProductRepo: Get.find()));
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

    /// cart
    Get.lazyPut(() => CartController(cartRepo: Get.find()));
    Get.lazyPut(() => CartRepo(sharedStore: Get.find()));

    /// favorite
    Get.lazyPut(() => FavoriteController(favoriteRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => FavoriteRepo(sharedStore: Get.find()));
  }
}

class ThemeBindings implements Bindings {
  @override

  Future<void> dependencies() async {
    final sharedStore = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedStore);
    Get.lazyPut(() => ThemeAppController(), fenix: true);
  }

}

class DataBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.find<ProductController>().getPopularProductList();
    await Get.find<ProductController>().getRecommendedProductList();
    // // local
    Get.find<CartController>().getItemsListLocal();
    Get.find<FavoriteController>().getItemsListLocal();
  }
}

class AllPageBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GuidingController>(() => GuidingController());
    Get.lazyPut(() => MenuController());
  }
}
