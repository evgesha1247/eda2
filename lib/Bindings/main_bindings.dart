import 'package:get/get.dart';
import '../app/page/auth/auth_model.dart';
import '../app/page/guiding/guiding_model.dart';
import '../app/page/splash/splash_model.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidingScreenModel>(() => GuidingScreenModel());
    Get.lazyPut<SplashModel>(() => SplashModel());
    Get.lazyPut<AuthModel>(() => AuthModel(), fenix: true);
    // Get.lazyPut<HomeModel>(() => HomeModel());
    //Get.lazyPut<MenuModel>(() => MenuModel());
    // Get.lazyPut<FavoriteModel>(() => FavoriteModel());
    // Get.lazyPut<CartModel>(() => CartModel());

    // Get.lazyPut<DishDetailedModel>(() => DishDetailedModel(), fenix: true);
  }
}
