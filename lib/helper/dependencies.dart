import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/favorite_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import 'package:text/app/theme/theme_app.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/ali_client.dart';
import '../app/data/repository/favorite_repo.dart';
import '../app/data/repository/product_repo.dart';
import '../app/pages/indirect_pages/auth/auth_model.dart';
import '../app/pages/indirect_pages/splash/splash_controller.dart';
import '../app/pages/primary_pages/guiding/guiding_model.dart';
import '../app/controllers/menu_controller.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstansts.BASE_URL));
  Get.lazyPut(() => ThemeAppController());
  Get.lazyPut(() => ProductController(
        popularProductRepo: Get.find(),
        recommendedProductRepo: Get.find(),
      ));

  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

  final sharedStore = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedStore, fenix: true);
  // pageModel
  Get.lazyPut(() => GuidingScreenModel());
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => AuthModel());

  //cart
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => CartRepo(sharedStore: Get.find()));

  // favorite
  Get.lazyPut(() => FavoriteController(favoriteRepo: Get.find()));
  Get.lazyPut(() => FavoriteRepo(sharedStore: Get.find()));

  Get.lazyPut(() => MenuController());
}
