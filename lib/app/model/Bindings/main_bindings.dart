import 'package:get/get.dart';
import '../cart/cart_model.dart';
import '../favorite/favorite_model.dart';
import '../guiding/guiding_model.dart';
import '../home/home_model.dart';
import '../menu/menu_model.dart';

class GuidingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GuidingScreenModel>(GuidingScreenModel());
    Get.lazyPut<HomeModel>(() => HomeModel());
    Get.lazyPut<MenuModel>(() => MenuModel());
    Get.lazyPut<FavoriteModel>(() => FavoriteModel());
    Get.lazyPut<CartModel>(() => CartModel());
  }
}
