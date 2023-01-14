import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/controllers/auth_controller.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/pages/primary_pages/favorite/controller/favorite_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/api_client.dart';
import '../app/data/repository/auth_repo.dart';
import '../app/data/repository/favorite_repo.dart';
import '../app/data/repository/product_repo.dart';
import '../app/pages/primary_pages/menu/controller/menu_controller.dart';
import '../app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import '../app/routes/main_routes.dart';
import '../app/theme/theme_controller.dart';
import '../utils/app_constants.dart';
import '../../../firebase_options.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

class Dependencies {
  Future<void> init() => _constructor();
  Future<void> _constructor() async {

      try {
        await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        ).then((value) => Get.find<AuthRepo>());
    } catch (e) {
      debugPrint('not init firebase');
      debugPrint('$e');
      Get.offAllNamed(MainRoutes.getGuiding);
    }

  }
}

class ApiBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(ApiClient(appBaseUrl: AppConstansts.BASE_URL));
    Get.lazyPut(() => AuthRepo(), fenix: true);
  }
}


class ControllersBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    /// product
    Get.lazyPut(() => ProductController(productRepo: Get.find()));
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


class AllPageBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GuidingController>(() => GuidingController());
    Get.lazyPut(() => MenuController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
