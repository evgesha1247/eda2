import 'package:get/get.dart';
import 'package:text/app/model/favorite/favorite_model.dart';
import 'package:text/app/model/guiding/guiding_model.dart';
import 'package:text/app/model/menu/menu_model.dart';

import '../home/home_model.dart';

class GuidingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GuidingScreenModel>(GuidingScreenModel());
    Get.lazyPut<HomeModel>(() => HomeModel());
    Get.lazyPut<MenuModel>(() => MenuModel());
    Get.lazyPut<FavoriteModel>(() => FavoriteModel());
  }
}
