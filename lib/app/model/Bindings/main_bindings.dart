import 'package:get/get.dart';
import '../cart/cart_model.dart';
import '../dish_detailed/dish_detailed_model.dart';
import '../favorite/favorite_model.dart';
import '../guiding/guiding_model.dart';
import '../home/home_model.dart';
import '../menu/menu_model.dart';
import '../splash/splash_model.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GuidingScreenModel>(GuidingScreenModel());
    Get.lazyPut<SplashModel>(() => SplashModel());
    Get.lazyPut<HomeModel>(() => HomeModel());
    Get.lazyPut<MenuModel>(() => MenuModel());
    Get.lazyPut<FavoriteModel>(() => FavoriteModel());
    Get.lazyPut<CartModel>(() => CartModel());
    Get.lazyPut<DishDetailedModel>(() => DishDetailedModel(), fenix: true);
  }
}
