import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/page_controller/favorite_controller.dart';
import 'package:text/app/data/repository/cart_repo.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_screen.dart';
import '../app/controllers/product_controller.dart';
import '../app/data/api/api_client.dart';
import '../app/data/repository/auth_repo.dart';
import '../app/data/repository/favorite_repo.dart';
import '../app/data/repository/product_repo.dart';
import '../app/controllers/page_controller/menu_controller.dart';
import '../app/pages/primary_pages/guiding/guiding_controller.dart';
import '../app/routes/main_routes.dart';
import '../app/theme/theme_controller.dart';
import '../utils/app_constants.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import '../../../firebase_options.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

class Dependencies {
  Future<void> init() => _constructor();
  Future<void> _constructor() async {
    if (defaultTargetPlatform != TargetPlatform.linux) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ).then((value) => Get.find<AuthRepo>());
      } catch (e) {
        print('not init firebase $e');
        GetPlatform.isDesktop
            ? () => Get.offAllNamed(MainRoutes.getGuiding)
            : null;
      }
    } else {
      Get.offAllNamed(MainRoutes.getGuiding);
    }
  }
}

class ApiBindings implements Bindings {
  @override
  Future<void> dependencies() async {
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


class AllPageBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GuidingController>(() => GuidingController());
    Get.lazyPut(() => MenuController(), fenix: true);
  }
}
