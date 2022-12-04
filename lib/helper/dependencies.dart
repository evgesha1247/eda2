import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/ali_client.dart';
import '../app/data/repository/favorite_repo.dart';
import '../app/data/repository/product_repo.dart';
import '../app/pages/indirect_pages/auth/auth_model.dart';
import '../app/pages/indirect_pages/splash/splash_model.dart';
import '../app/pages/primary_pages/guiding/guiding_model.dart';
import '../app/controllers/menu_controller.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstansts.BASE_URL));

  Get.lazyPut(() => ProductController(
        popularProductRepo: Get.find(),
        recommendedProductRepo: Get.find(),
      ));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
}

Future<void> initPageConfig() async {
  // db local
  final sharedStore = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedStore, fenix: true);

  // pageModel
  Get.lazyPut(() => GuidingScreenModel());
  Get.lazyPut(() => SplashModel());
  Get.lazyPut(() => AuthModel());

  //controller
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
  Get.lazyPut(() => FavoriteController(favoriteRepo: Get.find()));
  Get.lazyPut(() => MenuController());

  // repo
  Get.lazyPut(() => CartRepo(sharedStore: Get.find()), fenix: true);
  Get.lazyPut(() => FavoriteRepo());

}
