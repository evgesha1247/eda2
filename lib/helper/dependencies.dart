import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/ali_client.dart';
import '../app/data/repository/product_repo.dart';
import '../app/page/auth/auth_model.dart';
import '../app/page/guiding/guiding_model.dart';
import '../app/page/splash/splash_model.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstansts.BASE_URL));

  // repo
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

//controller

  Get.lazyPut(() => ProductController(
        popularProductRepo: Get.find(),
        recommendedProductRepo: Get.find(),
      ));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));

//
  Get.lazyPut(() => GuidingScreenModel());
  Get.lazyPut(() => SplashModel());
  Get.lazyPut(() => AuthModel());
}
